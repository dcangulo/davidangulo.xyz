---
categories: ['General Programming']
tags: ['Ruby']
title: 'Pretty print data in Ruby'
---
In the previous post we have learned to [pretty print JSON in JavaScript](/posts/pretty-print-json-in-javascript). Now we'll try to do the same with Ruby.

As a Rails developer, I have been dealing with Rails console almost every day, trying out various hacky commands, reading data, etc.

But reading large data in Rails console can sometimes be difficult. Here I introduce you to [awesome_print](https://github.com/awesome-print/awesome_print) gem.

## Installing the gem
In your `Gemfile`, under `:development` group
```ruby
group :development do 
  # ... your other dev dependencies

  gem 'awesome_print'
end
```
{: file='Gemfile' }

This will install the gem on development mode only so that it doesn't add bloat on production as this is only most used in development. 

You can however still install it globally so that you can use it in production if that's what you want.

After adding to the `Gemfile` we can now run the following on the terminal:
```console
$ bundle
```

## What does it do?

The gem allows us to pretty print data with full color and proper indention. It also supports various frameworks such as Ruby on Rails and Sinatra, various template engines such as `erb`, `haml`, and `slim`.

## How to use it and some examples

### Rails console and IRB
If you're using Rails console, `awesome_print` is autoloaded in the console. But if you're using `IRB` you might still need to run `require 'awesome_print'` first before you can use the `ap` function.

```ruby
irb(main):001:0> data = [ false, 42, %w(forty two), { :now => Time.now, :class => Time.now.class, :distance => 42e42 } ]
=> [false, 42, ["forty", "two"], {:now=>2022-12-30 11:27:27.083736 +0800, :class=>Time, :distance=>4.2e+43}]
irb(main):002:0> ap data
[
    [0] false,                  
    [1] 42,                     
    [2] [                       
        [0] "forty",            
        [1] "two"               
    ],                          
    [3] {                       
             :now => 2022-12-30 11:27:27.083736 +0800,
           :class => Time < Object,
        :distance => 4.2e+43
    }
]
=> nil
```
{: file='Rails Console' }

Notice that on `001`'s return the data seem a bit hard to read since it's presented as one liner and does not show indention.

But with the same data on `002` where `ap` function is used, the data are presented in a much clearer state, showing the right indention.

### Template Engines

Another example I would show you is when it's used in a template engine, in this example we would use the default Rails' template engine `erb`.

Notice that if you use:
```erb
<%= User.all.to_json %>
```

![before](/assets/images/posts/pretty-print-data-in-ruby/before.png)
_Picture 1. Before using ap_

The output on the browser is unreadable.


```erb
<%= ap(User.all).html_safe %>
```

![after](/assets/images/posts/pretty-print-data-in-ruby/after.png)
_Picture 2. After using ap_

The output on the browser become clearly readable.

## Conclusion

The gem can be pretty useful on a day-to-day basis when developing Ruby apps. It also works with many data types such as `Array`, `Hash`, `ActiveRecord`, etc. The gem also have many other functionalities aside from listed above, you may want to head over to the gem's documentation to read more:

See: [https://github.com/awesome-print/awesome_print#usage](https://github.com/awesome-print/awesome_print#usage)
