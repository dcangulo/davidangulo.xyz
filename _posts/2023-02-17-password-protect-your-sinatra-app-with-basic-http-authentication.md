---
categories: ['Website Development']
tags: ['Sinatra', 'Ruby', 'Authentication']
title: 'Password protect your Sinatra app with basic HTTP authentication'
---
Have you ever visited a site that asks you to provide a username and password on a form that resembles a JavaScript `alert`? That is an example of a basic HTTP auth.

Sometimes we don't need to implement an app-level sophisticated authentication to password protect our Sinatra app. Personally, I primarily use basic HTTP authentication for an internal use app formerly deployed on Heroku and for staging apps that I need to restrict access to.

This tutorial assumes that you have valid Ruby and Bundler installation already.

## Step 1: Create a blank Sinatra app.
You can skip this step if you already have a running Sinatra app.

```console
$ mkdir sinatra-app
$ cd sinatra-app
$ touch Gemfile
```

In your `Gemfile` add the following:
```ruby
source 'https://rubygems.org'

gem 'sinatra'
```
{: file='Gemfile' }

Then run:
```console
$ bundle install
```

We'll then create our app.
```console
$ touch app.rb
```

In your `app.rb`:
```ruby
require 'sinatra/base'

class Application < Sinatra::Base
  get '/' do
    'My Secret Page'
  end

  run!
end
```
{: file='app.rb' }

Let's test our app as it should work at this point.

```console
$ ruby app.rb
```

It should be accessible on [http://localhost:4567](http://localhost:4567) by default.

This is a simple Sinatra app that prints `My Secret Page` when accessed.

## Step 2: Add basic HTTP authentication.
Once we confirmed that our app is working, we can now add a basic HTTP authentication.

We will add the following snippet:
```ruby
use Rack::Auth::Basic, 'Restricted Area' do |username, password|
  username == 'myusername' && password == 'P@ssw0rd'
end
```

This adds support for basic HTTP authentication to our app. We don't need to install Rack separately since Sinatra already includes it for us.

The block has 2 arguments `username` and `password` where the value comes from the form inputted by the user. This block must return a boolean `true` if success and `false` if the authentication fails.

In our example, we would only be able to access our Sinatra app when we put `myusername` and `P@ssw0rd` in the form.

Our app would now look like this:
```ruby
require 'sinatra/base'

class Application < Sinatra::Base
  use Rack::Auth::Basic, 'Restricted Area' do |username, password|
    username == 'myusername' && password == 'P@ssw0rd'
  end

  get '/' do
    'My Secret Page'
  end

  run!
end
```
{: file='app.rb' }

At this point, we are now finished on adding basic HTTP authentication to our Sinatra app.

## Step 3 (Optional): Putting credentials in an environment variable.
Sometimes we may not want to hardcode `username` and `password` in our app.

To do this we can use the [dotenv gem](https://rubygems.org/gems/dotenv).

```console
$ bundle add dotenv
$ bundle install
$ touch .env
```

In your `.env` add the following:
```text
USERNAME=myusername
PASSWORD=P@ssw0rd
```
{: file='.env' }

We can now change our app to look like this:
```ruby
require 'sinatra/base'
require 'dotenv/load'

class Application < Sinatra::Base
  use Rack::Auth::Basic, 'Restricted Area' do |username, password|
    username == ENV.fetch('USERNAME', nil) && password == ENV.fetch('PASSWORD', nil)
  end

  get '/' do
    'My Secret Page'
  end

  run!
end
```
{: file='app.rb' }

We just added `require 'dotenv/load'` to load our `.env` file into our application and replaced the hardcoded `username` and `password` with `ENV.fetch('USERNAME', nil)` and `ENV.fetch('PASSWORD', nil)` where `nil` is the default value in case you forgot to define `USERNAME` and `PASSWORD` in your `.env` file. 

You can replace `nil` with any default value you want.
