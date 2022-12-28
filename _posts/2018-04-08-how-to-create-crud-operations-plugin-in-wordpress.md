---
categories: ['Website Development']
tags: ['MySQL', 'PHP', 'WordPress', 'WordPress Plugin']
title: 'How to create a CRUD operations plugin in WordPress'
---
In this tutorial, we would learn how to create crud operations plugin in WordPress.

This tutorial will demonstrate a WordPress plugin that can do CRUD (Create/Insert, Read/Select, Update, Delete) operations.

Since we are creating a plugin that interacts with the database you might want to read these tutorials [How to connect to WordPress database](/posts/how-to-connect-to-wordpress-database/) and [How to insert data into WordPress database](/posts/how-to-insert-data-into-wordpress-database/) to have a better understanding on database operations in WordPress.

## Step 1: Create a database table.
We are dealing with crud database operations so we need to have database table to store be able to store data.

```php
register_activation_hook(__FILE__, 'crudOperationsTable');

function crudOperationsTable() {
  global $wpdb;
  $charset_collate = $wpdb->get_charset_collate();
  $table_name = $wpdb->prefix . 'userstable';
  $sql = "CREATE TABLE `$table_name` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(220) DEFAULT NULL,
  `email` varchar(220) DEFAULT NULL,
  PRIMARY KEY(user_id)
  ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
  ";

  if ($wpdb->get_var("SHOW TABLES LIKE '$table_name'") != $table_name) {
    require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
    dbDelta($sql);
  }
}
```

The [`register_activation_hook()`](https://codex.wordpress.org/Function_Reference/register_activation_hook) function will make sure that it will automatically create a database table using the code inside the function `crudOperationsTable`.

The query will be a simple [`CREATE TABLE`](https://www.w3schools.com/sql/sql_create_table.asp) statement to create the database table.

You may read the detailed tutorial on [How to create database tables when your plugin is activated](/posts/how-to-create-database-tables-when-your-plugin-is-activated/).

## Step 2: Create a page to show the table.
We will be creating a simple HTML table to show the records that we have in the database.

You can create any page you want whether a [shortcode page](/posts/how-to-create-custom-wordpress-shortcode-plugin-from-scratch/), [admin page](/posts/how-to-create-an-admin-page-for-your-wordpress-plugin/), or even [settings page](/posts/how-to-create-a-settings-page-for-your-wordpress-plugin/) but in this tutorial we would just be using an admin page.

```php
add_action('admin_menu', 'addAdminPageContent');

function addAdminPageContent() {
  add_menu_page('CRUD', 'CRUD', 'manage_options', __FILE__, 'crudAdminPage', 'dashicons-wordpress');
}

function crudAdminPage() {
  global $wpdb;
  $table_name = $wpdb->prefix . 'userstable';
}
```

The `add_action` together with [`add_menu_page()`](https://developer.wordpress.org/reference/functions/add_menu_page/) will hook our function to WordPress so that we can use this function to write our own code.

We will write the code inside the `crudAdminPage()` function. In this example, we already have added two lines of code that we need to interact with the database.

## Step 3: Create an HTML table.
```html
<div class="wrap">
  <h2>CRUD Operations</h2>
  <table class="wp-list-table widefat striped">
    <thead>
      <tr>
        <th width="25%">User ID</th>
        <th width="25%">Name</th>
        <th width="25%">Email Address</th>
        <th width="25%">Actions</th>
      </tr>
    </thead>
    <tbody>
    </tbody>
  </table>
</div>
```

We will use the default WordPress CSS classes to design our table. However, if you want to design it your own and use frameworks such as bootstrap or create your own classes would also be fine.

In our table will have a **User ID**, **Name**, **Email Address** and **Actions** column. This is almost the same as the table that we have created in the database except that it doesn’t have the actions column.

## Step 4: Create the create/insert function.
Before we can populate the HTML table, we need to have data in the database so we would be needing to create or insert data first.

Inside the `<tbody></tbody>` tag, we will just create a row for our insert form.

```html
<form action="" method="post">
  <tr>
    <td><input type="text" value="AUTO_GENERATED" disabled></td>
    <td><input type="text" id="newname" name="newname"></td>
    <td><input type="text" id="newemail" name="newemail"></td>
    <td><button id="newsubmit" name="newsubmit" type="submit">INSERT</button></td>
  </tr>
</form>
```

We will keep the form action to blank since we will use the same page to process the data.

Now, let’s add the PHP code to process the form data. Keep also in mind that we have used the method post in our form.

```php
if (isset($_POST['newsubmit'])) {
  $name = $_POST['newname'];
  $email = $_POST['newemail'];
  $wpdb->query("INSERT INTO $table_name(name,email) VALUES('$name','$email')");
  
  echo "<script>location.replace('admin.php?page=crud.php');</script>";
}
```
We just created a block of code that will only be executed when our insert form in Step 4 is submitted.

To insert the data, we will just use the [`INSERT INTO`](https://www.w3schools.com/sql/sql_insert.asp) statement and it will be executed with the use of [`$wpdb->query()`](https://developer.wordpress.org/reference/classes/wpdb/query/) function.

The last line of code will just make sure that it automatically reloads the page so we can see the newly added record on our table.

## Step 5: Populate the HTML table.
Now that we have created an insert function, we can now populate the database with records. Before you proceed make sure that you have atleast one (1) record to see the result of this step.

```php
<?php
  $result = $wpdb->get_results("SELECT * FROM $table_name");
  
  foreach ($result as $print) {
    echo "
      <tr>
        <td width='25%'>$print->user_id</td>
        <td width='25%'>$print->name</td>
        <td width='25%'>$print->email</td>
        <td width='25%'><a href='admin.php?page=crud.php&upt=$print->user_id'><button type='button'>UPDATE</button></a> <a href='admin.php?page=crud.php&del=$print->user_id'><button type='button'>DELETE</button></a></td>
      </tr>
    ";
  }
?>
```

We will fetch the records from the database using the [`$wpdb->get_results()`](https://developer.wordpress.org/reference/classes/wpdb/get_results/) function, this is the function that executes our select statement and returns the records as an array.

To get the array values, we have used the [`foreach()`](https://php.net/manual/en/control-structures.foreach.php) loop and return a row to our table for every data found in the database. The action column for each record would be update and delete.

This step would be the read/select function.

## Step 6: Create the update function.
When we retrieve the data from the database, we have created two (2) buttons in the actions column. One of them is the update button that acts as an anchor tag.

This button will add the id of the record that we are going to edit.

```php
<?php
  if (isset($_GET['upt'])) {
    $upt_id = $_GET['up'];
    $result = $wpdb->get_results("SELECT * FROM $table_name WHERE user_id='$upt_id'");
    foreach($result as $print) {
      $name = $print->name;
      $email = $print->email;
    }
    echo "
    <table class='wp-list-table widefat striped'>
      <thead>
        <tr>
          <th width='25%'>User ID</th>
          <th width='25%'>Name</th>
          <th width='25%'>Email Address</th>
          <th width='25%'>Actions</th>
        </tr>
      </thead>
      <tbody>
        <form action='' method='post'>
          <tr>
            <td width='25%'>$print->user_id <input type='hidden' id='uptid' name='uptid' value='$print->user_id'></td>
            <td width='25%'><input type='text' id='uptname' name='uptname' value='$print->name'></td>
            <td width='25%'><input type='text' id='uptemail' name='uptemail' value='$print->email'></td>
            <td width='25%'><button id='uptsubmit' name='uptsubmit' type='submit'>UPDATE</button> <a href='admin.php?page=crud.php'><button type='button'>CANCEL</button></a></td>
          </tr>
        </form>
      </tbody>
    </table>";
  }
?>
```

We just created a condition where if the `user_id` to be edited is available then we would show a table containing the record we are going to edit.

Just like in the insert function, this will just be a form but the only difference is that it already contains the previous record ready to be changed/updated.

It will have two (2) buttons, the first button will be the confirmation button that will submit the form if you want to confirm the changes and the second button which is the cancel button that will simply reload and remove the `user_id` from the URL.

We will also set the form action to blank and method to post.

Now, we are going to add another code to process our update form.

```php
if (isset($_POST['uptsubmit'])) {
  $id = $_POST['uptid'];
  $name = $_POST['uptname'];
  $email = $_POST['uptemail'];
  $wpdb->query("UPDATE $table_name SET name='$name',email='$email' WHERE user_id='$id'");
  
  echo "<script>location.replace('admin.php?page=crud.php');</script>";
}
```

This code will only be executed if our update form is submitted.

We will also use the `$wpdb->query()` function to execute an [`UPDATE SET`](https://www.w3schools.com/sql/sql_update.asp) statement and the last line of code to also reload the page to see the results.

## Step 7: Create the delete function.
Same with the update function. The delete button will also add the `user_id` to the URL of the record to be deleted.

```php
if (isset($_GET['del'])) {
  $del_id = $_GET['del'];
  $wpdb->query("DELETE FROM $table_name WHERE user_id='$del_id'");
  
  echo "<script>location.replace('admin.php?page=crud.php');</script>";
}
```

So the condition for our delete function to be executed is when the delete button is clicked and the `user_id` is detected in the URL then it will execute the delete query to delete the record from the database then reloads the page to see the result.

## Complete code:
```php
<?php
/*
Plugin Name: CRUD Operations
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: A simple plugin that allows you to perform Create (INSERT), Read (SELECT), Update and Delete operations.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
License: GPL2
*/
register_activation_hook(__FILE__, 'crudOperationsTable');

function crudOperationsTable() {
  global $wpdb;
  $charset_collate = $wpdb->get_charset_collate();
  $table_name = $wpdb->prefix . 'userstable';
  $sql = "CREATE TABLE `$table_name` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(220) DEFAULT NULL,
  `email` varchar(220) DEFAULT NULL,
  PRIMARY KEY(user_id)
  ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
  ";
  if ($wpdb->get_var("SHOW TABLES LIKE '$table_name'") != $table_name) {
    require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
    dbDelta($sql);
  }
}

add_action('admin_menu', 'addAdminPageContent');

function addAdminPageContent() {
  add_menu_page('CRUD', 'CRUD', 'manage_options' ,__FILE__, 'crudAdminPage', 'dashicons-wordpress');
}
function crudAdminPage() {
  global $wpdb;
  $table_name = $wpdb->prefix . 'userstable';

  if (isset($_POST['newsubmit'])) {
    $name = $_POST['newname'];
    $email = $_POST['newemail'];
    $wpdb->query("INSERT INTO $table_name(name,email) VALUES('$name','$email')");
    echo "<script>location.replace('admin.php?page=crud.php');</script>";
  }

  if (isset($_POST['uptsubmit'])) {
    $id = $_POST['uptid'];
    $name = $_POST['uptname'];
    $email = $_POST['uptemail'];
    $wpdb->query("UPDATE $table_name SET name='$name',email='$email' WHERE user_id='$id'");
    echo "<script>location.replace('admin.php?page=crud.php');</script>";
  }

  if (isset($_GET['del'])) {
    $del_id = $_GET['del'];
    $wpdb->query("DELETE FROM $table_name WHERE user_id='$del_id'");
    echo "<script>location.replace('admin.php?page=crud.php');</script>";
  }
  
  ?>
  <div class="wrap">
    <h2>CRUD Operations</h2>
    <table class="wp-list-table widefat striped">
      <thead>
        <tr>
          <th width="25%">User ID</th>
          <th width="25%">Name</th>
          <th width="25%">Email Address</th>
          <th width="25%">Actions</th>
        </tr>
      </thead>
      <tbody>
        <form action="" method="post">
          <tr>
            <td><input type="text" value="AUTO_GENERATED" disabled></td>
            <td><input type="text" id="newname" name="newname"></td>
            <td><input type="text" id="newemail" name="newemail"></td>
            <td><button id="newsubmit" name="newsubmit" type="submit">INSERT</button></td>
          </tr>
        </form>
        <?php
          $result = $wpdb->get_results("SELECT * FROM $table_name");
          foreach ($result as $print) {
            echo "
              <tr>
                <td width='25%'>$print->user_id</td>
                <td width='25%'>$print->name</td>
                <td width='25%'>$print->email</td>
                <td width='25%'><a href='admin.php?page=crud.php&upt=$print->user_id'><button type='button'>UPDATE</button></a> <a href='admin.php?page=crud.php&del=$print->user_id'><button type='button'>DELETE</button></a></td>
              </tr>
            ";
          }
        ?>
      </tbody>  
    </table>
    <br>
    <br>
    <?php
      if (isset($_GET['upt'])) {
        $upt_id = $_GET['upt'];
        $result = $wpdb->get_results("SELECT * FROM $table_name WHERE user_id='$upt_id'");
        foreach($result as $print) {
          $name = $print->name;
          $email = $print->email;
        }
        echo "
        <table class='wp-list-table widefat striped'>
          <thead>
            <tr>
              <th width='25%'>User ID</th>
              <th width='25%'>Name</th>
              <th width='25%'>Email Address</th>
              <th width='25%'>Actions</th>
            </tr>
          </thead>
          <tbody>
            <form action='' method='post'>
              <tr>
                <td width='25%'>$print->user_id <input type='hidden' id='uptid' name='uptid' value='$print->user_id'></td>
                <td width='25%'><input type='text' id='uptname' name='uptname' value='$print->name'></td>
                <td width='25%'><input type='text' id='uptemail' name='uptemail' value='$print->email'></td>
                <td width='25%'><button id='uptsubmit' name='uptsubmit' type='submit'>UPDATE</button> <a href='admin.php?page=crud.php'><button type='button'>CANCEL</button></a></td>
              </tr>
            </form>
          </tbody>
        </table>";
      }
    ?>
  </div>
  <?php
}
```

That’s pretty much it. I hope you understand some basic database operations in WordPress.
