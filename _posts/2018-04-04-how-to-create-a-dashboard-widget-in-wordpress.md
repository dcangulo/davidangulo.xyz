---
categories: ['Website Development']
tags: ['PHP', 'WordPress', 'WordPress Plugin']
title: 'How to create a dashboard widget in WordPress'
---
In this tutorial, we would be learning on how to create a dashboard widget in WordPress.

If ever that you are developing a plugin that needs a report generation then this one is the perfect tutorial for you. This tutorial will make your plugin able to show a widget in your administrator dashboard.

You can use this for many things such as sales summary if you are on e-commerce, or something like login attempts if you are on a security plugin.

Some famous plugins that use a dashboard widget are [Yoast SEO](https://wordpress.org/plugins/wordpress-seo/) and [Wordfence](https://wordpress.org/plugins/wordfence/).

## Step 1: Setup the hook for your dashboard widget.
```php
add_action('wp_dashboard_setup', 'registerDashboardWidget');

function registerDashboardWidget() {
  wp_add_dashboard_widget('My Widget', 'My Widget', 'myPluginDashboardWidget');
}
```

This step is important for WordPress to detect that we are creating a dashboard widget.

You can change **My Widget**, this will be the title of your dashboard widget as seen in the featured post image.

The last parameter `myPluginDashboardWidget` will be the function name that will hold the content for your dashboard widget.

## Step 2: Create the function for the content.
Since we have declared `myPluginDashboardWidget` as our function name in Step 1 then we must create a function with the same name.

You can change this function name to anything you want as long as the names must be the same.

```php
function myPluginDashboardWidget() {
  echo "<h2>Hello World!</h2><p>This is my plugin's dashboard widget.</p>";
}
```

In this example, we would just be print some generic text. The content of your dashboard widget will always be up to you. You can use PHP codes and HTML tags for the widget.

## Complete Code:
```php
<?php
/*
Plugin Name: Dashboard Widget Example
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: Just another WordPress plugin with dashboard widget.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
License: GPL2
*/

add_action('wp_dashboard_setup', 'registerDashboardWidget');

function registerDashboardWidget() { 
  wp_add_dashboard_widget('My Widget', 'My Widget', 'myPluginDashboardWidget');
}

function myPluginDashboardWidget() {
  echo "<h2>Hello World!</h2><p>This is my plugin's dashboard widget.</p>";
}
```

That’s it, just activate the plugin and navigate to your dashboard and it will show My Widget on the dashboard.
