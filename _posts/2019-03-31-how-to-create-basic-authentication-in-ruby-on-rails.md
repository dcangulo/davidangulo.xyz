---
categories: ['Website Development']
tags: ['Authentication', 'Ruby', 'Rails', 'Ruby on Rails']
title: 'How to create a basic authentication in Ruby on Rails'
---
In this tutorial, we will be creating a basic authentication in Ruby on Rails.

## Step 1: Adding a password_digest field to the model.
This field will be used for authenticating the user.

### Step 1.1-A: Coming from a fresh Rails project.
If you are doing this from a fresh project then you must first create a User model by running rails g model User in the terminal.

This will create a file in `db/migrate/xxxxx_create_users.rb` where `xxxxx` is the current date and time you ran the command.

In that file add the following:

```ruby
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.timestamps
    end
  end
end
```
{: file='db/migrate/xxxxx_create_users.rb' }

Return to your terminal and run:

```console
$ rake db:migrate
```

This will create a users table in the database with columns username and password digest.

### Step 1.1-B: Coming from an existing Rails project.
If you are doing this from an existing project then you must add `password_digest` field to your existing model.

In this tutorial, we will be using `User` as the model. Feel free to change it on your preference.

Run the following command in the terminal:

```console
$ rails g migration add_password_digest_to_users
```

This will create a file in `db/migrate/xxxxx_add_password_digest_to_users.rb`

In that file add the following:

```ruby
class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
  end
end
```
{: file='db/migrate/xxxxx_add_password_digest_to_users.rb' }

Return to your terminal and run:

```console
$ rake db:migrate
```

This will add a string column `password_digest` to your users table in the database.

### Note:
In this step, you may notice that `ActiveRecord::Migration[5.2]` has `5.2` in it, you must change it to the correct version, otherwise, this might not work.

You might want to check your Rails version by running the following command in the terminal:

```console
$ rails -v
```

This tutorial is created using **Rails 5.2.3**.

## Step 2: Creating routes for the app.
Open `config/routes.rb` in your text editor.

In this file, we will define the links in our app. For this tutorial, we will be creating six (6) routes. one (1) that needs authentication and five (5) unauthenticated routes.

```ruby
Rails.application.routes.draw do
  # AUTHENTICATED ROUTES
  get '/dashboard' => 'dashboard#index' # THIS WILL BE THE DASHBOARD OF THE USER

  # UNAUTHENTICATED ROUTES
  get '/sign-up' => 'users#new' # THIS IS WHERE THE USER WILL REGISTER
  post '/save-user' => 'users#create' # THIS WILL BE THE PROCESS OF REGISTERING THE USER
  get '/' => 'sessions#new' # THIS IS WHERETHE USER WILL SIGN IN
  post '/' => 'sessions#create' # THIS WILL BE THE PROCESS OF SIGNING IN THE USER
  delete '/sign-out' => 'sessions#destroy' # THIS WILL BE THE PROCESS OF SIGNING OUT THE USER
end
```
{: file='config/routes.rb' }

## Step 3: Creating controllers for the routes.
At this point, our app will raise an error because the routes we defined doesn’t have a matching controller.

We can see that we used three (3) different controllers in Step 2. These are the dashboard, users, and sessions.

To create a matching controller for these routes you can run the following command in the terminal. One (1) at a time.

```console
$ rails g controller dashboard
$ rails g controller users
$ rails g controller sessions
```

This will create files in `app/controllers` directory.

In the dashboard controller `app/controllers/dashboard_controller.rb` add the following method:

```ruby
def index
end
```
{: file='app/controllers/dashboard_controller.rb' }

In the users controller `app/controllers/users_controller.rb` add the following method:

```ruby
def new
end

def create
end
```
{: file='app/controllers/users_controller.rb' }

In the sessions controller `app/controllers/sessions_controller.rb` add the following method:

```ruby
def new
end

def create
end

def destroy
end
```
{: file='app/controllers/sessions_controller.rb' }

If you observe the routes, it does not only matches to the controller but also matches to the methods in that controller.

The creation of method above ensures that our controller matches our routes.

## Step 4: Creating the dashboard page.
In the `app/views/dashboard/index.html.erb` paste the following code (create the file if it does not exists):

```html
DASHBOARD
```
{: file='app/views/dashboard/index.html.erb' }

This page will simply return a text **DASHBOARD** when `/dashboard` is accessed in the browser.

## Step 5: Creating a sign up page.
From the steps above, we know that the users controller handles these processes.

In your `app/controllers/users_controller.rb`, inside the new method, add the following:

```ruby
@user = User.new
```
{: file='app/controllers/users_controller.rb' }

In the `app/views/users/new.html.erb` paste the following code (create the file if it does not exists):

```erb
<h1>Sign Up</h1>
<%= form_with :model => @user, :url => '/save-user' do |f| %>
  <%= f.label :username %>
  <br>
  <%= f.text_field :username %>
  <br>
  <br>
  <%= f.label :password %>
  <br>
  <%= f.password_field :password %>
  <br>
  <br>
  <%= f.label :password_confirmation %>
  <br>
  <%= f.password_field :password_confirmation %>
  <br>
  <br>
  <%= f.submit %>
<% end %>
```
{: file='app/views/users/new.html.erb' }

This will show an HTML form when we access the link `/sign-up` in our browser that will make a `POST` request to `/save-user` when submitted.

Now, we are going to edit the method that will handle the data from our form.

In the same controller file add the following method:

```ruby
private

def user_params
  params.require(:user).permit :username, :password, :password_confirmation
end
```
{: file='app/controllers/users_controller.rb' }

This is to let to know that our app only permits `username`, `password`, and `password_confirmation` which is coming from our form to prevent malicious parameters to be processed.

In the `create` method add the following code:

```ruby
@user = User.new user_params

if @user.save
  session[:user_id] = @user.id
  redirect_to '/dashboard'
else
  redirect_to '/sign-up'
end
```
{: file='app/controllers/users_controller.rb' }

Basically, we are just creating a new instance of `User` and its parameters.

If it was saved successfully then we will set the newly registered user to be the current user and redirect it the dashboard but returns back to sign up page if the registration fails.

## Step 6: Creating the sign in page.
In the `app/views/sessions/new.html.erb` paste the following code (create the file if it does not exists):

```erb
<h1>Sign In</h1>
<%= form_with :url => '/' do |f| %>
  <%= f.label :username %>
  <br>
  <%= f.text_field :username %>
  <br>
  <br>
  <%= f.label :password %>
  <br>
  <%= f.password_field :password %>
  <br>
  <br>
  <%= f.submit %>
<% end %>
```
{: file='app/views/sessions/new.html.erb' }

Now that we created the form, we now have to authenticate the credentials if it matches a record in the database.

In your `app/controllers/sessions_controller.rb`, inside the create method, add the following:

```ruby
@user = User.find_by :username => params[:username]

if @user && @user.authenticate(params[:password])
  session[:user_id] = @user.id
  redirect_to '/dashboard'
else
  redirect_to '/'
end
```
{: file='app/controllers/sessions_controller.rb' }

What the code does is that it finds the user with the supplied username and authenticates its password.

It sets the session and redirects to the dashboard if it succeeds then redirects back it to the sign in page if it doesn’t.

## Step 7: Creating the sign out function.
In your `app/controllers/sessions_controller.rb`, inside the destroy method, add the following:

```ruby
session[:user_id] = nil

redirect_to '/'
```
{: file='app/controllers/sessions_controller.rb' }

We are just going to set the `session[:user_id]` that we defined in the sign up and sign in back to its original value which is `nil` and redirects back the user to the sign in page.

## Step 8: Creating the helper methods.
In your `app/controllers/application_controller.rb`, add the following:

```ruby
helper_method :current_user

def current_user
  @current_user ||= User.find_by :id => session[:user_id]
end

def authorize
  redirect_to '/' unless current_user
end
```
{: file='app/controllers/application_controller.rb' }

A helper method is a method that we can access in our views. The helper method current user holds the data of the currently authenticated user.

The authorize method is a method that we can call to our routes that needs a user to be authenticated before allowing access to a resource.

In this case, we defined `/dashboard` to be the only route that needs authentication before being accessed.

In your `app/controllers/dashboard_controller.rb`, add the following:

```ruby
class DashboardController < ApplicationController
  def index
    authorize
    # YOUR OTHER CODE HERE
  end
end
```
{: file='app/controllers/dashboard_controller.rb' }

This simply calls authorize method and redirects back to the user to the sign in page if no user is authenticated.

If you want the whole controller to be authenticated instead:

```ruby
class DashboardController < ApplicationController
  before_action :authorize

  def index
  end

  def method1
  end
  
  def method2
  end
end
```
{: file='app/controllers/dashboard_controller.rb' }

This will authenticate not just the index method but also `method1` and `method2`.

## Step 9: Adding the links in the view.
We created all this routes, pages, and stuff but we didn’t have links to access this pages at all without manually typing the links in the browser.

In your `app/views/layouts/application.html.erb`, add the following inside the `<body>` above the `<%= yield %>`:

```erb
<% if current_user %>
  Hi <%= current_user.username %>! | <%= link_to 'Sign Out', '/sign-out', :method => :delete %>
<% else %>
  <%= link_to 'Sign In', '/' %> | <%= link_to 'Sign Up', '/sign-up' %>
<% end %>
<br>
<br>
```
{: file='app/views/layouts/application.html.erb' }

What it does is printing the name of user and a sign out link if it’s authenticated and sign in and sign up links if it’s unauthenticated.

## Step 10: Installing bcrypt gem.
Our app may look complete at this point, but if you run it at this state, you will just encounter a lot of errors because we are lacking the core function of this tutorial.

In your `Gemfile` uncomment the following:

```ruby
gem 'bcrypt', '~> 3.1.7'
```
{: file='Gemfile' }

But if it does not exists, add it instead.

In your terminal run:

```console
$ bundle install
```

In your `app/models/user.rb`, add the following:

```ruby
class User < ApplicationRecord
  has_secure_password
end
```
{: file='app/models/user.rb' }

## Step 11: Run the app.
In your terminal run:

```console
$ rails s
```

You should be able to see the sign in page as your startup page if you access [http://localhost:3000/](http://localhost:3000/) in your browser.

That’s it. This is just a basic authentication in Rails for learning purposes.
