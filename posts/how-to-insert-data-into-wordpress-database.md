# how to insert data into wordpress database

To insert data into WordPress database, we have learned that you need to connect the database. If you don't know how you can refer to the previous topic entitled **[How to connect to WordPress database](https://www.davidangulo.xyz/wp/website-development/how-to-connect-to-wordpress-database/)**.

After a successful connection to the database, we should start by populating it with data. We will once again use the `$wpdb` object to make modifications in the database.

In the previous topic, we left at having the following code:
```php
function myFunction() {     
  global $wpdb; 
} 
```

The code above is needed to make a connection to the database.

## Using the `$wpdb->insert()`

WordPress has another way of inserting into the database. This is not your usual using of `INSERT INTO` statement.

The basic syntax for inserting data to WordPress database is `<?php $wpdb->insert($table_name, $data); ?>`. The `$table_name` is a string that is the name of the database table to insert data into. On the other hand, `$data` is an array that will be inserted into the database table.

Now we have learned the basic syntax for the WordPress insert, we should have a code like this:
```php
function myFunction() {     
  global $wpdb;     
  $table_name = $wpdb->prefix . 'my_table';     
  $wpdb->insert($table_name, array('column_1' => $data_1, 'column_2' => $data_2, //other columns and data (if available) ...)); 
} 
```

For example, I have a table named `wp_myExampleTable` that looks like this:
![db-table](images/db-table.jpeg)
*Figure 1. Newly created table named `wp_myExampleTable`.*

* `content_id` is the primary key which has a type of `integer` with auto increment.
* `content_message` is a `varchar` type that has a length of 200.
* `content_date` has a type of `datetime`.

I will try to insert some data into `wp_myExampleTable` using the code below:
```php
function myFunction() {     
  global $wpdb;     
  $table_name = $wpdb->prefix . 'myExampleTable';     
  $message = 'Insert to database tutorial.';     
  $date = date('Y-m-d H:i:s');     
  $wpdb->insert($table_name, array('content_id' => NULL, 'content_message' => $message, 'content_date' => $date)); 
} 
```

If the code runs without any error then the data is successfully inserted into the database. The table `wp_myExampleTable` should now look like this:

![db-table](images/db-table-with-record.jpeg)
*Figure 2. `wp_myExampleTable` after running the script.*

Assuming that we run this script at exactly December 19, 2017 at 1:00 in the afternoon.

## Using the `$wpdb->query()`

I personally use this method to insert since I am familiar with SQL queries. This method can be used in executing any SQL queries. So if you are familiar or more comfortable in using SQL queries then this would fit you more.

The basic syntax for this method would be `<?php  $wpdb->query($query); ?>`. `$query` is a string variable that holds the SQL query to execute. For this example, we would be using the `INSERT INTO` statement.

If we are going to insert another data in the `wp_myExampleTable` table then we should run the code below:

```php
function mySecondFunction() {     
  global $wpdb;     
  $table_name = $wpdb->prefix . 'myExampleTable';     
  $message = 'Another method of insert.';     
  $date = date('Y-m-d H:i:s');     
  $wpdb->query("INSERT INTO $table_name(content_id, content_message, content_date) VALUES(NULL, '$message', '$date')"); 
} 
```

![db-table](images/db-table-with-multiple-records.jpeg)
*Figure 3. `wp_myExampleTable` after using the other method.*

The database table should look like this if we successfully inserted the new data.

Assuming that we run the script at exactly after five (5) minutes.

That's it. I hope you learned something.
