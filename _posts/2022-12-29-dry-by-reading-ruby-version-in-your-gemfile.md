---
categories: ['General Programming']
tags: ['Ruby']
title: 'DRY by reading .ruby-version in your Gemfile'
---
Most Ruby projects have a `.ruby-version` file that is used by different version managers to automatically switch Ruby version based on the content of that file. Very useful if you have many projects with different Ruby versions.

But the same Ruby version is also sometimes declared in the project's `Gemfile`.

## You might have something like

Your `.ruby-version`
```text
3.2.0
```
{: file='.ruby-version' }

Your `Gemfile`
```ruby
ruby "3.2.0"
```
{: file='Gemfile' }

Both are the same values but on a different file, if you need to update your Ruby version, you would need to update both which is a bit tedious and prone to forgetting.

When you somehow got a mismatched version on those files you might get the following error:
```text
Your Ruby version is 3.2.0, but your Gemfile specified 3.1.0
```

## How do we improve it?

`Gemfile` is just another Ruby script that is executed when running `bundle`, you can just treat it as a simple Ruby script.

In your `Gemfile` you can do:
```ruby
ruby File.read(File.join(__dir__, ".ruby-version")).strip
```
{: file='Gemfile' }

I have seen on other sources that they are using a shorter version such as:
```ruby
ruby File.read(".ruby-version").strip
```
{: file='Gemfile' }

The problem with this is that `bundle` stops working if you navigate into a directory. 

An example on where this is necessary is on a React Native app, where the `Gemfile` and `.ruby-version` is on the root directory but you have to run `cd ios; bundle exec pod install`, that code raises the following error.

```text
[!] There was an error parsing `Gemfile`: No such file or directory @ rb_sysopen - .ruby-version. Bundler cannot continue.

 #  from /Users/davidangulo/myapp/Gemfile:5
 #  -------------------------------------------
 #  
 >  ruby File.read(".ruby-version").strip
 #  
 #  -------------------------------------------
```

Because `.ruby-version` is no longer present in my current directory which is `ios`.

To make `bundle` work on any subdirectory, I used `File.join(__dir__, ".ruby-version")`, where `__dir__` is the current directory of the `Gemfile`, this assumes that the `Gemfile` and `.ruby-version` are always in the same directory. So instead of executing in the `current` directory it executes based on the `Gemfiles` directory.

> See: [https://github.com/facebook/react-native/pull/35410](https://github.com/facebook/react-native/pull/35410)

## Conclusion

We have now DRYed our Ruby version declaration and only needs to be changed in one place instead of multiple.

You can use the shorter version if you don't need to run `bundle` on a subdirectory.

Use the longer version to make it path agnostic and works everywhere on your project.
