---
categories: ['Website Development']
tags: ['PayPal', 'Payment Gateway', 'Ruby', 'Rails', 'Ruby on Rails']
title: 'Simple PayPal checkout in Ruby on Rails using Orders API v2'
---
Recently, Paypal archived most of their SDK repositories that uses v1 of the API and added a deprecation notice. This includes the [PayPal-Ruby-SDK](https://github.com/paypal/PayPal-Ruby-SDK).

In this tutorial, we would be moving away from [PayPal-Ruby-SDK](https://github.com/paypal/PayPal-Ruby-SDK) and use [Checkout-Ruby-SDK](https://github.com/paypal/Checkout-Ruby-SDK) as this is the recommended according to the Paypal developer documentation. The Checkout-Ruby-SDK uses v2 of the API instead of the deprecated v1.

We will make this tutorial as simple as possible, we will hard code everything from products to orders. It is up to you on how will you optimize and implement a better UI for this.

## Step 1: Initialize a Rails application
You can initalize a Rails application by running the following commands in the terminal.

```sh
rails new paypal-checkout
cd paypal-checkout
```

## Step 2: Install the gem
In your `Gemfile` add the following:

```ruby
gem 'paypal-checkout-sdk'
```

And then run the following in the terminal.

```sh
bundle install
```

## Step 3: Create an Order model
This will be the model where we’ll store the transactions.

```sh
rails g model Order
```

This will create a model file and a migration. In the migration add the following:

```ruby
def change
  create_table :orders do |t|
    t.boolean :paid, :default => false
    t.string :token
    t.integer :price
    t.timestamps
  end
end
```

The `paid` will determine if the order is paid or not. The `token` will be your PayPal reference. The `price` will the total amount of the transaction (sum of prices of all products), we will just hard code it for simplicity and also used `integer` to make it simple. Please use appropriate data type on your project.

```sh
rails db:migrate
```

This will migrate our migration and create table in the database for our records.

## Step 4: Create the routes
In your `config/routes.rb`, add the following:

```ruby
Rails.application.routes.draw do
  get '/', :to => 'orders#index'
  post :create_order, :to => 'orders#create_order'
  post :capture_order, :to => 'orders#capture_order'
end
```

## Step 5: Create the controller
This will be the controller for the routes that we created in the previous step.

```sh
rails g controller Orders
```

In `app/controllers/orders_controller.rb`, add the following methods:

```ruby
class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index; end
  def create_order
    # PAYPAL CREATE ORDER
  end
  def capture_order
    # PAYPAL CAPTURE ORDER
  end
end
```

## Step 6: Add the Paypal smart payment button
You can see the Paypal smart button interactive demo to customize your button.

In `app/views/orders/index.html.erb`, add the following: (create the file if it not exists)

```html
<div id="paypal-button-container"></div>
<script src="https://www.paypal.com/sdk/js?client-id=YOUR-PAYPAL-CLIENT-ID"></script>
<script>
  paypal.Buttons({
    env: 'sandbox', // Valid values are sandbox and live.
    createOrder: async () => {},
    onApprove: async (data) => {}
  }).render('#paypal-button-container');
</script>
```

Replace `YOUR-PAYPAL-CLIENT-ID` with your client id. If you don’t have one, you can create by clicking [this link](https://developer.paypal.com/developer/applications). You can also create sandbox accounts using [this link](https://developer.paypal.com/developer/accounts).

## Step 7: Connecting the button to the backend
Let us first initialize our Checkout SDK.

In `app/controllers/orders_controller.rb`, add the following methods:

```ruby
class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :paypal_init, :except => [:index]
  def index; end
  def create_order
    # PAYPAL CREATE ORDER
  end
  def capture_order
    # PAYPAL CAPTURE ORDER
  end
  private
  def paypal_init
    client_id = 'YOUR-CLIENT-ID'
    client_secret = 'YOUR-CLIENT-SECRET'
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
```

This will make `@client` available in our `create_order` and `capture_order` methods.

Inside `create_order`, we can now generate a token for the order using the following code:

```ruby
def create_order
  price = '100.00'
  request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
  request.request_body({
    :intent => 'CAPTURE',
    :purchase_units => [
      {
        :amount => {
          :currency_code => 'USD',
          :value => price
        }
      }
    ]
  })

  begin
    response = @client.execute request
    order = Order.new
    order.price = price.to_i
    order.token = response.result.id
    if order.save
      return render :json => {:token => response.result.id}, :status => :ok
    end
  rescue PayPalHttp::HttpError => ioe
    # HANDLE THE ERROR
  end
end
```

This will create an order and returns us a token from Paypal, while doing that we are also creating a record in our database using the `Order` model. [Click this for more info](https://github.com/paypal/Checkout-Ruby-SDK#creating-an-order).

Now in the frontend, we can now use this token. In the `paypal.Buttons`, inside `createOrder` function, we must return this token for our button to process.

```js
createOrder: async () => {
  const response = await fetch('/create_order', { method: 'POST' });
  const responseData = await response.json();

  return responseData.token;
}
```

The next would be the `onApprove` function where the data will be passed after the payment has been approved.

```js
onApprove: async (data) => {
  const response = await fetch('/capture_order', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ order_id: data.orderID })
  });

  const responseData = await response.json();

  if (responseData.status === 'COMPLETED') {
    alert('COMPLETED');
    // REDIRECT TO SUCCESS PAGE
  }
}
```

If the backend gives a `COMPLETED` response, we can now redirect the user to the success page.

Let us create the backend that would capture the order. In `app/controllers/orders_controller.rb`, inside `capture_order` add the following:

```ruby
def capture_order
  request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]

  begin
    response = @client.execute request
    order = Order.find_by :token => params[:order_id]
    order.paid = response.result.status == 'COMPLETED'

    if order.save
      return render :json => {:status => response.result.status}, :status => :ok
    end
  rescue PayPalHttp::HttpError => ioe
    # HANDLE THE ERROR
  end
end
```
This will capture the order and give a status if the order has been completed. [Click this for more info](https://github.com/paypal/Checkout-Ruby-SDK#capturing-an-order).

If the status is now completed then we can set the order as **paid**, and return a **COMPLETED** in the frontend to know if the process is success.

## Step 8: Test the app
In your terminal.

```sh
rails s
```

In your browser go to [http://localhost:3000/](http://localhost:3000/) and you should see a Paypal button if everything is successful.

If you clicked the Paypal button, a new tab should appear and an `Order` must be created in your database that has `token`, `price`, and `paid` set as `false`.

Once you complete the payment, the tab should close and the order record paid column now must be set to `true`, and an alert the says `COMPLETED` should appear.

That’s it. We have now created a simple Paypal checkout in Ruby on Rails.
