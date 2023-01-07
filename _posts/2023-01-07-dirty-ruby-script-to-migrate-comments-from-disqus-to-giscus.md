---
categories: ['Meta']
tags: ['Ruby', 'Disqus', 'giscus']
title: 'Dirty Ruby script to migrate comments from Disqus to giscus'
---
> Use the script at your own risk. Please try it first on a sample repository before committing too hard as it may bombard your discussions page. Only tested on <1k of comments, so far I haven't encountered any GitHub rate limit error using this script.
{: .prompt-warning }

I recently migrated my blog from WordPress that uses Disqus comment system to Jekyll static site where I use giscus. One of the hiccups that I have encountered is on how to migrate comments from Disqus to giscus.

I have read different blogs, GitHub issues specifically [https://github.com/giscus/giscus/issues/330](https://github.com/giscus/giscus/issues/330), but they all offer different solutions. I have seen scripts written in variety of languages such as Java, C#, R, and many others.

## What is giscus?
[giscus](https://giscus.app/) is a comments system powered by [GitHub Discussions](https://docs.github.com/en/discussions).

It seemed the perfect choice for me as I also host the source code of this site on GitHub, it makes sense that the discussion revolves around the content of the site.

## My dirty Ruby script

```ruby
require 'active_support/all'
require 'graphql/client'
require 'graphql/client/http'

PERSONAL_ACCESS_TOKEN = '' # FILL IT UP
REPOSITORY_ID = '' # FILL IT UP
CATEGORY_ID = '' # FILL IT UP
REPO_OWNER = '' # FILL IT UP
REPO_NAME = '' # FILL IT UP
ENDPOINT = 'https://api.github.com/graphql'

HttpAdapter = GraphQL::Client::HTTP.new(ENDPOINT) do
  def headers(context)
    {
      'Authorization' => "Bearer #{PERSONAL_ACCESS_TOKEN}",
      'User-Agent' => 'Ruby'
    }
  end
end
Schema = GraphQL::Client.load_schema(HttpAdapter)
Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)

disqus = Hash.from_xml(File.read('comments.xml'))['disqus']
threads = disqus['thread']
slugs = threads.map { |thread| thread['link'].split('/').last }.reject(&:blank?).uniq.sort

NewDiscussionQuery = Client.parse <<-'GRAPHQL'
  mutation($repository_id: ID!, $category_id: ID!, $title: String!, $body: String!) {
    createDiscussion(input: {repositoryId: $repository_id, categoryId: $category_id, title: $title, body: $body}) {
      discussion {
        id
      }
    }
  }
GRAPHQL

def create_discussion(slug)
  print('.')
  sleep(5)

  title = "posts/#{slug}/" # FILL IT UP
  response = Client.query(NewDiscussionQuery, { 
    variables: {
      repository_id: REPOSITORY_ID,
      category_id: CATEGORY_ID,
      title: title,
      body: "<h1>#{title}</h1><a href='https://www.davidangulo.xyz/#{title}'>https://www.davidangulo.xyz/#{title}</a>" # FILL IT UP 
    }
  })

  return create_discussion(slug) if response.errors.any?
end

slugs.each { |slug| create_discussion(slug) }

DiscussionListQuery = Client.parse <<-'GRAPHQL'
  query($owner: String!, $name: String!) {
    repository(owner: $owner, name: $name) {
      discussions(first: 100) {
        nodes {
          id
          title
          url
        }
      }
    }
  }
GRAPHQL

response = Client.query(DiscussionListQuery, {
  variables: {
    owner: REPO_OWNER,
    name: REPO_NAME
  }
})

discussions = response.original_hash['data']['repository']['discussions']['nodes'].map do |discussion|
  {
    :id => discussion['id'],
    :slug => discussion['title'].split('/').last
  }
end

comments = disqus['post'].map do |comment|
  next if comment['message'].blank?

  anonymous = comment['author']['isAnonymous'] == 'true'
  username = anonymous ? nil : comment['author']['username']
  slug = threads.find { |thread| thread['dsq:id'] == comment['thread']['dsq:id'] }['link'].split('/').last
  discussion_id = discussions.find { |discussion| discussion[:slug] == slug }[:id]

  {
    :username => username,
    :name => anonymous ? 'Anonymous' : comment['author']['name'],
    :disqus_profile_link => anonymous ? nil : "https://disqus.com/by/#{username}/",
    :message => comment['message'],
    :created_at => comment['createdAt'],
    :discussion_id => discussion_id
  }
end.reject(&:blank?)

NewCommentQuery = Client.parse <<-'GRAPHQL'
  mutation($discussion_id: ID!, $body: String!) {
    addDiscussionComment(input: {discussionId: $discussion_id, body: $body}) {
      comment {
        id
      }
    }
  }
GRAPHQL

def create_comment(comment)
  print '.'
  sleep(5)

  created_at = comment[:created_at].to_datetime.strftime('%Y-%m-%d %H:%M:%S')
  body =
    if comment[:username].blank?
      "<i>This comment was originally posted by an Anonymous user on #{created_at}.</i><br>#{comment[:message]}"
    else
      "<i>This comment was originally posted by <a href='#{comment[:disqus_profile_link]}'>#{comment[:name]} (@#{comment[:username]})</a> on #{created_at}.</i><br>#{comment[:message]}"
    end

  response = Client.query(NewCommentQuery, {
    variables: {
      discussion_id: comment[:discussion_id],
      body: body
    }
  })

  return create_comment(comment) if response.errors.any?
end

comments.each { |comment| create_comment(comment) }
puts '.'
```
{: file='migrator.rb'}

## Step 1: Export your Disqus comments as XML.
You can export your Disqus comments by going to [http://disqus.com/admin/discussions/export/](http://disqus.com/admin/discussions/export/).

Put that XML file in a folder and rename it for easier access, personally I named it `comments.xml`.

## Step 2: Install dependencies.

I have 2 dependencies for this script, so I initialized a `Gemfile`.
```ruby
source 'https://rubygems.org'

gem 'activesupport', '~> 7.0', '>= 7.0.4'
gem 'graphql-client', '~> 0.18.0'
```
{: file='Gemfile'}

`activesupport` allows us to convert XML into a Ruby hash while `graphql-client` allows us to interact with GitHub's GraphQL API.

In your terminal run:
```console
$ bundle install
```

## Step 3: Generate a Personal Access Token (PAT).
You can generate PAT by going to [https://github.com/settings/tokens](https://github.com/settings/tokens).

The PAT needs the following scopes:
* public_repo
* write:discussion
  * read:discussion

## Step 4: Fill up the script's needed fields.
You need to change the values of all variables that has `# FILL IT UP` comment.

```ruby
PERSONAL_ACCESS_TOKEN = ''
REPOSITORY_ID = ''
CATEGORY_ID = ''
REPO_OWNER = ''
REPO_NAME = ''
```

`PERSONAL_ACCESS_TOKEN` is the token you have generated from Step 3.

If you have already successfully setup giscus you should already have `REPOSITORY_ID` and `CATEGORY_ID`.

`REPO_OWNER` is the owner of the repository in my case `dcangulo`.

`REPO_NAME` is the repository under the owner in my case `davidangulo.xyz`.

I set up giscus to match by `pathname`, in my case the posts lives in the route `posts/:slug/`. So I use `"posts/#{slug}/"` for my `title`. For the `body` I simply put the `title` followed by a link to the post.

```ruby
"<h1>#{title}</h1><a href='https://www.davidangulo.xyz/#{title}'>https://www.davidangulo.xyz/#{title}</a>" 
```

![thread](/assets/images/posts/dirty-ruby-script-to-migrate-comments-from-disqus-to-giscus/thread.png)
_Picture 4.1. How it would look like_

You need to change it to match yours.

## Step 5: Initialize GraphQL Client.
```ruby
HttpAdapter = GraphQL::Client::HTTP.new(ENDPOINT) do
  def headers(context)
    {
      'Authorization' => "Bearer #{PERSONAL_ACCESS_TOKEN}",
      'User-Agent' => 'Ruby'
    }
  end
end
Schema = GraphQL::Client.load_schema(HttpAdapter)
Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)
```

## Step 6: Migrate Disqus threads to giscus.
```ruby
disqus = Hash.from_xml(File.read('comments.xml'))['disqus'] # Read the content of comments.xml and convert to Hash
threads = disqus['thread'] # Access iteratable Disqus threads
slugs = threads.map { |thread| thread['link'].split('/').last }.reject(&:blank?).uniq.sort # Generate pathnames based on slug

NewDiscussionQuery = Client.parse <<-'GRAPHQL'
  mutation($repository_id: ID!, $category_id: ID!, $title: String!, $body: String!) {
    createDiscussion(input: {repositoryId: $repository_id, categoryId: $category_id, title: $title, body: $body}) {
      discussion {
        id
      }
    }
  }
GRAPHQL # GraphQL query that creates a discussion

def create_discussion(slug)
  print('.')
  sleep(5) # To not bombard GitHub with so many requests.

  title = "posts/#{slug}/"
  response = Client.query(NewDiscussionQuery, { 
    variables: {
      repository_id: REPOSITORY_ID,
      category_id: CATEGORY_ID,
      title: title,
      body: "<h1>#{title}</h1><a href='https://www.davidangulo.xyz/#{title}'>https://www.davidangulo.xyz/#{title}</a>" 
    }
  })

  return create_discussion(slug) if response.errors.any? # Retry if encountered an error, probably rate limit.
end

slugs.each { |slug| create_discussion(slug) } # Create a discussion for each Disqus threads.
```

![discussions](/assets/images/posts/dirty-ruby-script-to-migrate-comments-from-disqus-to-giscus/discussions.png)
_Picture 6.1. List of discussions with posts/:slug as the title pattern_

## Step 7: List all giscus threads.
If we succeed creating giscus threads for each Disqus threads, we will now need to get them to access the `discussion_id`.

```ruby
DiscussionListQuery = Client.parse <<-'GRAPHQL'
  query($owner: String!, $name: String!) {
    repository(owner: $owner, name: $name) {
      discussions(first: 100) {
        nodes {
          id
          title
        }
      }
    }
  }
GRAPHQL # GraphQL query that lists all discussion within a repository.

response = Client.query(DiscussionListQuery, {
  variables: {
    owner: REPO_OWNER,
    name: REPO_NAME
  }
})

discussions = response.original_hash['data']['repository']['discussions']['nodes'].map do |discussion|
  {
    :id => discussion['id'],
    :slug => discussion['title'].split('/').last # I generated the title as `"posts/#{slug}/"` before then I can just get the last to reget the slug.
  }
end
```

## Step 8: Migrate comments from Disqus to giscus.
```ruby
comments = disqus['post'].map do |comment|
  next if comment['message'].blank? # some comments are blank so we'll just skip it.

  anonymous = comment['author']['isAnonymous'] == 'true' # Checks if the commenter is anonymous
  username = anonymous ? nil : comment['author']['username'] # Blank username for anonymous users
  slug = threads.find { |thread| thread['dsq:id'] == comment['thread']['dsq:id'] }['link'].split('/').last # Get the slug
  discussion_id = discussions.find { |discussion| discussion[:slug] == slug }[:id] # Get the `discussion_id` based on slug matching from Step 7

  {
    :username => username,
    :name => anonymous ? 'Anonymous' : comment['author']['name'],
    :disqus_profile_link => anonymous ? nil : "https://disqus.com/by/#{username}/",
    :message => comment['message'],
    :created_at => comment['createdAt'],
    :discussion_id => discussion_id
  }
end.reject(&:blank?) # remove blank from array

NewCommentQuery = Client.parse <<-'GRAPHQL'
  mutation($discussion_id: ID!, $body: String!) {
    addDiscussionComment(input: {discussionId: $discussion_id, body: $body}) {
      comment {
        id
      }
    }
  }
GRAPHQL # GraphQL query that create a comment on a discussion

def create_comment(comment)
  print('.')
  sleep(5) # To not bombard GitHub with so many requests.

  created_at = comment[:created_at].to_datetime.strftime('%Y-%m-%d %H:%M:%S') # Format the time
  body =
    if comment[:username].blank?
      "<i>This comment was originally posted by an Anonymous user on #{created_at}.</i><br>#{comment[:message]}" # Content for anonymous users
    else
      "<i>This comment was originally posted by <a href='#{comment[:disqus_profile_link]}'>#{comment[:name]} (@#{comment[:username]})</a> on #{created_at}.</i><br>#{comment[:message]}" # Content for non-anonymous users and link to their Disqus profile for reference
    end

  response = Client.query(NewCommentQuery, {
    variables: {
      discussion_id: comment[:discussion_id],
      body: body
    }
  })

  return create_comment(comment) if response.errors.any? # Retry if encountered an error, probably rate limit.
end

comments.each { |comment| create_comment(comment) } # Create a comment on appropriate discussion.
puts '.'
```

![comments](/assets/images/posts/dirty-ruby-script-to-migrate-comments-from-disqus-to-giscus/comments.png)
_Picture 8.1. List of comments_

## Step 9: Run the script.
In your terminal run:
```console
$ ruby migrator.rb
```

You should see a `.` for each iteration.

I hope this is useful for you.
