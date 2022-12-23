---
categories: ['Website Development']
tags: ['JavaScript', 'PHP']
---
In this tutorial we would be learning on how to pass value from JavaScript to PHP.

Are you looking for PHP to JavaScript and not this one? You might want to view [How to pass value from PHP to JavaScript](/posts/how-to-pass-value-from-php-to-javascript) instead.

## Step 1: Create an HTML file.
For this example, we would create an HTML file named `index.html`, this file will contain our client-side scripts.

## Step 2: Include a jQuery file.

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
```

We would be needing this additional library to perform asynchronous communication with the server from the browser or client.

## Step 3: Declare the JavaScript variable.

```html
<script>     
  var myJsVar = 'Hello World!'; 
</script>
```

In this example we would be passing the string `Hello World!` from JavaScript to PHP.

## Step 4: Create a PHP file.
You need to create a PHP file that will contain our server-side scripts. For this example, we would be creating a file named `ajax.php` in the same directory with the file created in Step 1.

## Step 5: Declare the PHP variable.
```php
<?php     
  $my_php_var = ''; 
?>
```

This PHP variable is initialized in the file `ajax.php`.

## Step 6: Create an AJAX call.
```js
$.ajax({     
  type: 'POST',     
  url: 'ajax.php',     
  data: {
    myJsVar: myJsVar     
  },     
  success: function(response) {     
    // do something on success response
  },     
  error: function(response) {     
    // do something on error response
  } 
});
```

You should include this code after the declaration of our JavaScript variable. The method **type** that will be using is **POST**.

If you are familiar with the form method is that there are **POST** and **GET** methods, the type in this are just the same.

The value for the **url** is the file that we have created in Step 4.
The value for the **data** is the variable name of our JavaScript variable declared in Step 3.

For the **success** and **error** function, you can handle the result of our AJAX call. If the call succeeds then do something in the success function, and the same with the error function, just in case our script fails.

## Step 7: Assign the JS variable to the PHP variable.
```php
<?php      
  $my_php_var = $_POST['myJsVar']; 
?>
```
Since the value for the data in Step 6 is `myJsVar` and the type is **POST** we would be using the **POST** variable in the server-side containing the variable for data.

## Complete code:
**index.html**
```html
<!DOCTYPE html>
<html>     
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>     
  <script>         
    var myJsVar = 'Hello World!';         
    $.ajax({             
      type:'POST',             
      url: 'ajax.php',             
      data: {                 
        myJsVar: myJsVar             
      },             
      success: function(response) {                 
        // do something on success response         
      },             
      error: function(response) {                 
        // do something on error response  
      }         
    });     
  </script>
</html>
```

**ajax.php**
```php
<?php     
  $my_php_var = $_POST['myJVar']; 
?>
```

That’s it, we have successfully passed the value from JavaScript to PHP. I hope you learned something.
