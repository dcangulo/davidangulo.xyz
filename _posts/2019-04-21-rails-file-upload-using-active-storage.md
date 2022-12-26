---
categories: ['Website Development']
tags: ['Ruby', 'Rails', 'Ruby on Rails', 'File Upload', 'ActiveStorage']
---
In this tutorial, we would be learning to upload files in Rails. Rails file upload have become easier since the release of [Active Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html). It allows us to handle file uploads without using any gem.

This tutorial aims to deliver the simplest way to integrate Rails file upload. We would be skipping the details on how Active Storage works in the back and focus on how to integrate it correctly.

If you are already on an existing project and has a model that already has a CRUD operation then you may skip to **Step 3**.

## Step 1: Create a new Rails project.

In your terminal run the following commands.

```sh
rails new file-upload
cd file-upload
```

This will simply create a new Rails project and change our current directory in the newly created project.

## Step 2: Create a CRUD.
Since our focus is on file upload, we would be using scaffold to create our CRUD operations.

Scaffolding requires the following command in the terminal.

```sh
rails g scaffold post title:string content:text
```

This will create a `Post` model with a `title` and `content` columns, a database migration, and all views.

## Step 3: Install Active Storage.
You need to run the following command in the terminal.

```sh
rails active_storage:install
rake db:migrate
```

The command creates a database migration that hold the necessary data and makes file uploading possible. Since we have a new database migration, we would need to migrate it.

## Step 4: Add the necessary association.
In the file `app/models/post.rb` add the following association.

```ruby
class Post < ApplicationRecord
  has_one_attached :image
end
```

This will tell that our model allows an attachment `image`. The word `image` is user-defined and can be changed to anything you want.

Since we are using [`has_one_attached`](https://api.rubyonrails.org/classes/ActiveStorage/Attached/One.html), we are only expected to attach one image per record. If you want to attach many files in a single record you may want to use [`has_many_attached`](https://api.rubyonrails.org/classes/ActiveStorage/Attached/Many.html) instead.

## Step 5: Add the file upload field in the form.
The scaffold the we ran in Step 2 includes the views needed in our CRUD.

In the file `app/views/posts/_form.html.erb`, inside the form_with, add the following.

```erb
<div class="field">
  <%= form.label :image %>
  <%= form.file_field :image %>
</div>
```

This will add a file upload field in the form.

## Step 6: Process the new field in the controller.
All changes in this step will be done in the file `app/controllers/posts_controller.rb`.

First, we would need to whitelist the new field in the parameters. This is necessary to prevent attackers from passing malicious parameters to our controller.

```ruby
def post_params
  params.require(:post).permit(:title, :content, :image)
end
```

Second, we would need to attach our image in the controller’s create method.

```ruby
# POST /posts
# POST /posts.json
def create
  @post = Post.new(post_params)
  @post.image.attach(post_params[:image])
  respond_to do |format|
    if @post.save
      format.html { redirect_to @post, notice: 'Post was successfully created.' }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { render :new }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end
```

Notice that we just added `@post.image.attach(post_params[:image])` in the create method.

Third, we also need to attach our image in the update method.

```ruby
# PATCH/PUT /posts/1
# PATCH/PUT /posts/1.json
def update
  @post.image.purge
  @post.image.attach(post_params[:image])
  respond_to do |format|
    if @post.update(post_params)
      format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      format.json { render :show, status: :ok, location: @post }
    else
      format.html { render :edit }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end
```

In the update method we added `@post.image.purge` to ensure that the old attachments are deleted before we attach the new file. The next line after purge is the same as what we did in create method.

## Step 7: Show the uploaded file in the view.
Now that we are able to attach files on our records, we would want to view them in the view right?

In your file `app/views/posts/show.html.erb`, add the following.

```erb
<p>
  <% if @post.image.attached? %>
    <p>
      <strong>Image:</strong>
      <br>
      <%= image_tag @post.image %>
    </p>
  <% end %>
</p>
```

It will check if there is a file attached and if it does it will show the file.

You may want to run your app using `rails s` and navigate to [http://localhost:3000/posts](http://localhost:3000/posts) to confirm that everything works.

That’s it, we have now implemented a Rails file upload using Active Storage. Take note that all files will be saved on your local disk, you can also change this but that would be for another tutorial as this aims to deliver the most basic Rails file upload.
