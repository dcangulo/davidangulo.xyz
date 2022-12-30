---
categories: ['Website Development']
tags: ['Ruby', 'Rails', 'Ruby on Rails', 'File Upload', 'ActiveStorage']
title: 'Attach file URL on ActiveStorage Rails'
---
In a past post, we have learned to [attach base64 file on ActiveStorage](/posts/attach-base64-file-on-activestorage-rails). Now we will learn to attach a file URL to ActiveStorage.

## Use case
In my current job, we maintain REST APIs consumed by 3rd party companies with their own developers. 

There is an endpoint that needs a valid ID to be accessed, what those 3rd party companies pass to us is a `string` of the file URL where it can be downloaded.

Now we would need to make it an attachment to Rails ActiveStorage.

Another use case that I have encountered is when we migrated a CSV of products from a Shopify store to our Rails app, when you export Shopify products as CSV it adds a `Image Src` column that contains that product's image URL.

When migrating we need to attach that image URL in our Rails app ActiveStorage.

---

Let's initialize a blank Rails app with a model that has an image attachment.

## Step 1: Initialize our Rails app

You may skip this step if you already have a Rails app running.

```console
$ rails new test-app
$ cd test-app
$ bundle exec rails g scaffold post
$ bundle exec rails active_storage:install
$ bundle exec rails db:migrate
```

### What those commands above do?
* `rails new test-app` - initializes a blank Rails app named `test-app`.
* `cd test-app` - navigating into our new Rails app.
* `bundle exec rails g scaffold post` - scaffolded a `Post` model CRUD.
* `bundle exec rails active_storage:install` - installing `ActiveStorage`.
* `bundle exec rails db:migrate` - running all pending database migrations.

## Step 2: Add attachment to our Post model
In your `app/models/post.rb` add the following association.

```ruby
class Post < ApplicationRecord
  has_one_attached :image
end
```
{: file='app/models/post.rb' }

This creates an association between our `Post` model and `ActiveStorage`.

## Step 3: Create a sample Post record

Open our Rails console.
```console
$ bundle exec rails c
```

Create a sample `Post` record.
```ruby
Post.create
```

## Step 4: Attach an image URL to our Post model

We will use this [website's favicon](https://www.davidangulo.xyz/assets/img/favicons/favicon-16x16.png) for our sample image URL to be attached.

Open our Rails console again.
```console
$ bundle exec rails c
```

On our Rails console, we should require `OpenURI` module.
```ruby
require 'open-uri'
```

We'll now assign the content of the file URL to our `file` variable.
```ruby
file = URI.open('https://www.davidangulo.xyz/assets/img/favicons/favicon-16x16.png')
```

Then, we'll extract the `mime_type`.
```ruby
mime_type = file.content_type
```

There are cases that this is not served by the server, or the server does not serve that real mime type and spoof us. There are gems that can help us sniff the mime type of those files such as [ruby-filemagic](https://github.com/blackwinter/ruby-filemagic) and [fastimage](https://github.com/sdsykes/fastimage).

Then we'll use `strict_encode64` encode it in base64.
```ruby
encoded_file = Base64.strict_encode64(file.read)
```

We used `strict_encode64` so that it doesn't add `\n` to our base64 `string` unlike `encode64`.

Then we'll decode the `encoded_file`.
```ruby
decoded_file = Base64.decode64(encoded_file)
```

Generate filename with extension. It's up to you on how you will generate your filename, for simplicity we'll just use `RANDOM-UUID` + `extension`.

```ruby
extension = Rack::Mime::MIME_TYPES.invert[mime_type]
filename = [SecureRandom.uuid, extension].join
```

We used `Rack::Mime::MIME_TYPES` to get the extension based on the file's `mime_type` and `SecureRandom.uuid` to generate a random UUID.

> You may also read: [Advantages and Disadvantages of UUID](/posts/advantages-and-disadvantages-of-uuid)

Now we can attach the sample image to our record.
```ruby
Post.last.image.attach(
  io: StringIO.new(decoded_file),
  filename: filename,
  content_type: mime_type
)
```

## Step 5: DRY code.

Instead of copy-pasting the codes above every time, we can DRY our code a bit.

In your `app/models/concerns/attachable.rb`, paste the following. (create if it does not exist)

```ruby
require 'open-uri'

module Attachable
  def attach_file!(file_url, association)
    file = URI.open(file_url)
    mime_type = file.content_type
    encoded_file = Base64.strict_encode64(file.read)
    decoded_file = Base64.decode64(encoded_file)
    extension = Rack::Mime::MIME_TYPES.invert[mime_type]
    filename = [SecureRandom.uuid, extension].join

    self.send(association).attach(
      io: StringIO.new(decoded_file),
      filename: filename,
      content_type: mime_type
    )
  end
end
```
{: file='app/models/concerns/attachable.rb' }

We just created an `Attachable` module that we can include in our models.

In your `app/models/post.rb`, we can now do:

```ruby
class Post < ApplicationRecord
  include Attachable

  has_one_attached :image
end
```
{: file='app/models/post.rb' }

Then we can attach file to our `Post` record like the following code:

```ruby
file_url = 'https://www.davidangulo.xyz/assets/img/favicons/favicon-16x16.png'
post = Post.last # or any Post record
post.attach_file!(file_url, :image)
```

## Bonus

We could also set a custom directory where our files will be saved.

```diff
  self.send(association).attach(
+   key: ['custom-directory', filename].join('/'),  
    io: StringIO.new(decoded_file),
    filename: filename,
    content_type: mime_type
  )
```

That's it. We now learned to attach a file URL to ActiveStorage in Rails.
