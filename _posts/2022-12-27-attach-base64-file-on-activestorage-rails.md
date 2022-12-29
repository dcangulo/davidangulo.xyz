---
categories: ['Website Development']
tags: ['Ruby', 'Rails', 'Ruby on Rails', 'File Upload', 'ActiveStorage', 'base64']
title: 'Attach base64 file on ActiveStorage Rails'
---
[Base64](https://en.wikipedia.org/wiki/Base64) has been my go-to encoding when uploading files from my external front-end apps such as React Native to my Rails APIs.

It's a simple way to represent a binary data as string, where string is probably the common data passed through REST APIs.

We have learned to [upload using ActiveStorage](/posts/rails-file-upload-using-active-storage) before where our file is a Blob, but now it's in base64.

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

## Step 4: Attach an image to our Post model

What we will attach to our record created in the previous step is a **1 black pixel image**.

```text
data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUGFdjYGBg+A8AAQQBAHAgZQsAAAAASUVORK5CYII=
```

Any file should work but we only chose that for demonstration purposes and also to keep our base64 string short.

Open our Rails console again.
```console
$ bundle exec rails c
```

We'll assign our sample image to a variable.
```ruby
base64_file = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUGFdjYGBg+A8AAQQBAHAgZQsAAAAASUVORK5CYII="
```

Then, we'll extract the `mime_type`.
```ruby
mime_type = base64_file.split(',').first.split(';').first.split(':').last
```

Then, get the `base64` data.
```ruby
base64_data = base64_file.split(',').last
```

Then, decode the `base64_data`.
```ruby
decoded_base64 = Base64.decode64(base64_data)
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
  io: StringIO.new(decoded_base64),
  filename: filename,
  content_type: mime_type
)
```

## Step 5: DRY code.

Instead of copy-pasting the codes above every time, we can DRY our code a bit.

In your `app/models/concerns/attachable.rb`, paste the following. (create if it does not exist)

```ruby
module Attachable
  def attach_file!(base64_file, association)
    mime_type = base64_file.split(',').first.split(';').first.split(':').last
    base64_data = base64_file.split(',').last
    decoded_base64 = Base64.decode64(base64_data)
    extension = Rack::Mime::MIME_TYPES.invert[mime_type]
    filename = [SecureRandom.uuid, extension].join

    self.send(association).attach(
      io: StringIO.new(decoded_base64),
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
base64_file = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUGFdjYGBg+A8AAQQBAHAgZQsAAAAASUVORK5CYII="
post = Post.last # or any Post record
post.attach_file!(base64_file, :image)
```

## Bonus

We could also set a custom directory where our files will be saved.

```diff
  self.send(association).attach(
+   key: ['custom-directory', filename].join('/'),  
    io: StringIO.new(decoded_base64),
    filename: filename,
    content_type: mime_type
  )
```

That's it. We now learned to attach a base64 file to ActiveStorage in Rails.
