---
categories: ['Website Development']
tags: ['PHP', 'SEO']
title: 'How to create SEO friendly URL in PHP'
---
In this tutorial, we would be creating a PHP function that will convert a string to create an SEO friendly URL that can be used on your website.

We will also use some predefined PHP functions such as `strtolower` and `preg_replace` for this tutorial. The goal of this tutorial is to create an SEO friendly URL from a string.

You may see that the URL of this tutorial is https://www.davidangulo.xyz/how-to-create-seo-friendly-url-in-php/.

From that, we can observe the characteristics of an SEO friendly URL. First thing is that the URL is only composed of lowercase characters, no special characters, no whitespaces, and last no `%20` in the URL.

## Step 1: Create a function with a string parameter.
```php
function seoFriendlyUrl($string) {     
  return $string; 
}
```

We would be using the parameter `$string` to receive the data when our function is being invoked.

## Step2: Convert the string to lowercase.
```php
function seoFriendlyUrl($string) {     
  $string = strtolower($string);     
  return $string; 
}
```

This will now return a lowercase version of the string.

## Step 3: Remove special characters from the string.
```php
function seoFriendlyUrl($string) {     
  $string = strtolower($string);     
  $string = preg_replace('/[^a-z0-9_\s-]/', '', $string);     
  return $string; 
}
```

We added a line of code that will remove all special characters leaving only the alphanumeric present.

## Step 4: Remove all double dashes "–-" and double spaces "  "
```php
function seoFriendlyUrl($string) {     
  $string = strtolower($string);     
  $string = preg_replace('/[^a-z0-9_\s-]/', '', $string);     
  return $string; 
}
```

The next line of code will remove duplicates from spaces and dashes.

## Step 5: Convert all underscores and white spaces to dashes.
```php
function seoFriendlyUrl($string) {
  $string = strtolower($string);
  $string = preg_replace('/[^a-z0-9_\s-]/', '', $string);
  $string = preg_replace('/[\s_]/', '-', $string);
  return $string;
}
```

The last line of code that we added converts all underscore and spaces to dashes creating an SEO friendly URL. This will be the last step and this function will now return an SEO friendly URL.

## Basic usage:
```php
echo seoFriendlyUrl('How--to !create? SEO friendly url in PHP'); 
// This will print 'how-to-create-seo-friendly-url-in-php' without the quotes. 
```

That's pretty much it for this tutorial. I hope you have a good use for it.
