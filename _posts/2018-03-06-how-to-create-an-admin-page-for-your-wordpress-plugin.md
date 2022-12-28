---
categories: ['Website Development']
tags: ['WordPress', 'WordPress Plugin', 'PHP']
title: 'How to create an admin page for your WordPress plugin'
---
In this tutorial, we are going to create an admin page for your WordPress plugin.

If you are using some famous plugins such as **Yoast SEO**, you can see that they have their own admin menu page that can be seen in the WordPress sidebar menu.

## Step 1: Create a plugin file.
We will create a file named as `admin.php` and the content as follows:

```php
<?php
/* 
Plugin Name: My WordPress Plugin 
Plugin URI: https://wordpress.org/plugins/ 
Description: Just another WordPress plugin. 
Version: 1.0.0 
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
*/
```
## Step 2: Create a function.

```php
function adminPageContent() {     
  echo '<h2>My WordPress Plugin</h2>Hello world!'; 
}
```

The content of this function will be displayed when we visit the admin page of our plugin.

## Step 3: Add an action hook.

```php
add_action('admin_menu', 'addAdminPageContent');
```

Since we are going to add an admin menu to our plugin, we have used the `admin_menu` in the first parameter.

This hook will allow WordPress to process a specific action. The specific function that I am talking about will be tackled next step.

## Step 4: Call the add_menu_page function.

```php
function addAdminPageContent() {    
  add_menu_page('My Plugin', 'My Plugin', 'manage_options', __FILE__, 'adminPageContent', 'dashicons-wordpress'); 
}
```

The text **My Plugin** will be the name of our menu. `adminPageContent` is the name of the function that we have declared in Step 2. `dashicons-wordpress` will be the icon for our menu. You can select for more in [https://developer.wordpress.org/resource/dashicons](https://developer.wordpress.org/resource/dashicons).

## Complete code:

```php
<?php
/*
Plugin Name: My WordPress Plugin
Plugin URI: https://wordpress.org/plugins/
Description: Just another WordPress plugin.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
*/

function addAdminPageContent() {
  add_menu_page('My Plugin', 'My Plugin', 'manage_options', __FILE__, 'adminPageContent', 'dashicons-wordpress');
}

function adminPageContent() {
  echo '<h2>My WordPress Plugin</h2>Hello world!';
}

add_action('admin_menu', 'addAdminPageContent');
```

That’s it, just simply activate the plugin that we have created and it must add a menu in the sidebar with a WordPress logo as the icon and My Plugin as the menu title.
