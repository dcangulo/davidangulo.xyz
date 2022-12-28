---
categories: ['Website Development']
tags: ['MySQL', 'PHP', 'WordPress', 'WordPress Plugin']
title: 'How to create database tables when your plugin is activated'
---
In this tutorial, we would be learning on how to create database tables when your plugin is activated.

If you are developing your own WordPress plugin, chances are there are some data you need to save to keep your plugin running. Sometimes it can be inputs or some configurations on your plugin.

It is recommended that you create a separate database table if you need to store data for your plugin.

## Step 1: Hook a function when the plugin is activated.
```php
register_activation_hook(__FILE__, 'myPluginCreateTable');

function myPluginCreateTable() {
}
```

In this example, the function would be `myPluginCreateTable` and it is hooked by [`register_activation_hook()`](https://codex.wordpress.org/Function_Reference/register_activation_hook). The use of `register_activation_hook()` function is that it is executed when the plugin is activated.

When our plugin is activated it will execute the function `myPluginCreateTable()`.

## Step 2: Write the code for creating tables.
The code will be written inside the function that we have created earlier so that it will be automatically excuted when our plugin is activated.

```php
global $wpdb;
$charset_collate = $wpdb->get_charset_collate();
$table_name = $wpdb->prefix . 'customtable';
$sql = "CREATE TABLE `$table_name` (
`id` int(11) NOT NULL,
`column2` varchar(220) DEFAULT NULL,
`column3` varchar(220) DEFAULT NULL,
`column4` int(11) DEFAULT '1',
PRIMARY KEY(id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
";

if ($wpdb->get_var("SHOW TABLES LIKE '$table_name'") != $table_name) {
  require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
  dbDelta($sql);
}
```

In this process, we need to use the [`$wpdb`](https://codex.wordpress.org/Class_Reference/wpdb) object to interact with the database. You might want to read How to connect to WordPress database.

The table name that we are going to create will be named as `{your-prefix}_customtable` where `{your-prefix}` is depending on the prefix that you have saved during the installation process, it is commonly installed as `wp_`.

In order to make it more flexible, we will just fetch your own prefix using the `$wpdb->prefix` so that it will automatically adjust to whatever you have used during the installation.

The `$sql` variable will hold the query to be executed. Make sure that you write a valid create table query to make this work.

The next line would be a condition, it will only create the table if the table that we are creating is non-existent since we want to avoid the scenario when our plugin is deactivated and activated again as it will execute the create table twice.

We need to require the `upgrade.php` as this file makes it possible to upgrade the database. We are using the [`dbDelta()`](https://developer.wordpress.org/reference/functions/dbdelta/) function that can be found also in `upgrade.php`.

## Complete Code:
```php
<?php
/*
Plugin Name: Create database table
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: A simple WordPress plugin that creates a database table on activation.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz
License: GPL2
*/

register_activation_hook(__FILE__, 'myPluginCreateTable');

function myPluginCreateTable() {
  global $wpdb;
  $charset_collate = $wpdb->get_charset_collate();
  $table_name = $wpdb->prefix . 'customtable';
  $sql = "CREATE TABLE `$table_name` (
  `id` int(11) NOT NULL,
  `column2` varchar(220) DEFAULT NULL,
  `column3` varchar(220) DEFAULT NULL,
  `column4` int(11) DEFAULT '1',
  PRIMARY KEY(id)
  ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
  ";

  if ($wpdb->get_var("SHOW TABLES LIKE '$table_name'") != $table_name) {
    require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
    dbDelta($sql);
  }
}
```

That’s it. When your plugin is activated, it will automatically create a database table that you can use for your data.

In any case, you need help in populating your database tables I would recommend reading [How to insert data into WordPress database](/posts/how-to-insert-data-into-wordpress-database/).
