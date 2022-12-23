---
categories: ['Website Development']
tags: ['WordPress', 'WordPress Plugin', 'PHP']
---
In this tutorial, we would be creating a custom WordPress shortcode plugin.

I assumed that you are already familiar with WordPress plugins. We know that the WordPress plugins are composed of PHP files that can be found in `/wp-content/plugins/` directory.

## Step 1: Create a folder in the WordPress plugins directory.
I would be creating a folder entitled `shortcode-example`.

## Step 2: Create your plugin file inside the created folder.
In this example, we would be creating `index.php` in `/wp-content/plugins/shortcode-example/` as our main plugin file. The content of `index.php` is as follows:

```php
<?php 
/* 
Plugin Name: Example Shortcode Plugin 
Plugin URI: https://wordpress.org/plugins/ 
Description: Just another example shortcode plugin. 
Version: 1.0.0 
Author: David Angulo 
Author URI: https://www.davidangulo.xyz/wp/ 
*/ 
```

This will make WordPress recognize the file that we have created as a plugin.

## Step 3: Create a function that contains the content of our shortcode.

```php
class MyShortCode {
  public function myShortCodeContent() {         
    echo 'Hello! I am a custom shortcode.';     
  } 
} 
```

## Step 4: Create another function that will render your shortcode content.

```php
class MyShortCode {     
  public function myShortCodeRender() {
    ob_start();
    $this->myShortCodeContent(); 
    return ob_get_clean();
  }
} 
```

## Step 5: Add a hook for a shortcode tag.

```php
class MyShortCode {     
  public function __construct() {
    add_shortcode('my_custom_shortcode', array($this, 'myShortCodeRender'));    
  }
} 
```

The first parameter is the name of our shortcode while the second parameter is the name of the function that has the content. In this example, the name of the shortcode is `my_custom_shortcode`.

## Complete Code:

```php
<?php 
/* 
Plugin Name: Example Shortcode Plugin 
Plugin URI: https://wordpress.org/plugins/ 
Description: Just another example shortcode plugin. 
Version: 1.0.0 
Author: David Angulo 
Author URI: https://www.davidangulo.xyz/wp/ 
*/ 

class MyShortCode { 
  public function __construct() { 
    add_shortcode('my_custom_shortcode', array($this, 'myShortCodeRender')); 
  }

  public function myShortCodeContent() { 
    echo 'Hello! I am a custom shortcode.'; 
  }

  public function myShortCodeRender() { 
    ob_start(); 
    $this->myShortCodeContent();
    return ob_get_clean();
  }
}

$object = new MyShortCode;
```

## Basic usage:
In the WordPress visual editor use the shortcode as `[my_custom_shortcode]`.

This will return **Hello! I am a custom shortcode**.

That’s it we created a custom WordPress shortcode plugin. To test the plugin you must activate the plugin and it should not return any errors. In case there are any errors, just review the steps to find where it might have gone wrong.
