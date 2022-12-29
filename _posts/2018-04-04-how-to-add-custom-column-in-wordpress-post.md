---
categories: ['Website Development']
tags: ['PHP', 'WordPress', 'WordPress Plugin']
title: 'How to add custom column in WordPress post'
---
In this tutorial, we would be learning on how to add custom column in WordPress post.

If you are creating a plugin that is meant to be used on posts, then you might need this function.

You might have noticed that there are six (6) default columns in the WordPress posts table.

The goal of this tutorial is to add another column that will show the date when the post was last modified.

## Step 1: Set up the column header.
This will show the name that will appear as the header in the table. It will also hook our function to WordPress.

```php
add_filter('manage_posts_columns', 'column_head');

function column_head($columns) {
  $columns['custom_column'] = 'Last Modified Date';
  return $columns;
}
```

In this example, we would be naming our custom column as **Last Modified Date**.

## Step 2: Set up the column content.
Now that we have the header, we must put something in the table data. It can be anything you want.

```php
add_action('manage_posts_custom_column', 'column_content', 10, 2);

function column_content($column_name, $post_ID) {
  if ($column_name == 'custom_column') {
    echo 'Last Modified<br><abbr title=' . get_the_modified_time('Y/m/d') . get_the_modified_time('h:i:s a') . '>' . get_the_modified_time('Y/m/d') . '</abbr>';
  }
}
```

You can even use the `$post_ID` variable to uniquely identify each post.

We must put the condition on where would we put the content. It must be the same on the custom column name that we have created.

If you do not do this then it will be added to all custom column available and might conflict with other plugins with the same capabilities.

In this example, we would be showing a column composed of the date when the post was last modified.

## Complete Code:
```php
<?php
/*
Plugin Name: Custom Column Plugin Example
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: Add a custom column on WordPress posts.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz
License: GPL2
*/

add_filter('manage_posts_columns', 'column_head');

function column_head($columns) {
  $columns['custom_column'] = 'Last Modified Date';
  return $columns;
}

add_action('manage_posts_custom_column', 'column_content', 10, 2);

function column_content($column_name, $post_ID) {
  if ($column_name == 'custom_column') {
    echo 'Last Modified<br><abbr title=' . get_the_modified_time('Y/m/d') . get_the_modified_time('h:i:s a') . '>' . get_the_modified_time('Y/m/d') . '</abbr>';
  }
}
```

That’s it, we have now added the 7th column on the WordPress post page that shows when the post was last modified.
