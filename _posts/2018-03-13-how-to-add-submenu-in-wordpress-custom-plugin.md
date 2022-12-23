---
categories: ['Website Development']
tags: ['PHP', 'WordPress', 'WordPress Plugin']
---
This tutorial will guide you on how to add submenu to your custom WordPress plugin. Many big plugins have this functionality such as Yoast SEO plugin. So if you’re building a plugin you might need to add another page for it.

## Step 1: Add an admin page for your custom WordPress plugin.
Before you can start adding a child/submenu to your plugin, first is that you must have a parent menu to connect it from. If you don’t have the parent menu you can read this tutorial [how to create an admin page for your WordPress plugin](/posts/how-to-create-an-admin-page-for-your-wordpress-plugin/).

## Step 2: Create a function.

```php
function subMenu() {     
  echo "<h2>My WordPress Plugin</h2>Hello world! I'm the submenu."; 
}
```

This will hold the content of the submenu page. In this example, if you click to our submenu this the text in the echo statement will be the output.

## Step 3: Call the `add_submenu_page` function.

```php
add_submenu_page('appointments', 'Pending', 'Pending', 'manage_options', 'appointments-pending', 'subMenu');
```

This line of code should be included together with the `add_menu_page` in Step 1.

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

function addMenuHooks(){
  add_menu_page('Appointments', 'Appointments', 'manage_options', 'appointments', 'mainMenu','dashicons-calendar-alt');
  add_submenu_page('appointments', 'Pending', 'Pending', 'manage_options', 'appointments-pending', 'subMenu'); 
}

function mainMenu() {
  echo "<h2>My WordPress Plugin</h2>Hello world! I'm the main menu.";
}

function subMenu() {
  echo "<h2>My WordPress Plugin</h2>Hello world! I'm the submenu.";
}

add_action('admin_menu', 'addMenuHooks');
```

That’s it, just make sure to activate the plugin. Hover to the main menu of the plugin and the submenu should appear beside it.
