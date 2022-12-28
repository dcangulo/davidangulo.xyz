---
categories: ['Website Development']
tags: ['JavaScript', 'PHP']
title: 'How to pass value from PHP to JavaScript'
---
In this tutorial we would be learning on how to pass value from PHP to JavaScript.

Are you looking for JavaScript to PHP and not this one? You might want to view [How to pass value from JavaScript to PHP](/posts/how-to-pass-value-from-javascript-to-php) instead.

## Step 1: Declare the PHP variable.

```html
<?php     
  $my_php_var = 'Hello World!'; 
?>
```

In this example, we would be using a string variable named `$my_php_var` containing the string `Hello World!`.

## Step 2: Declare the JavaScript variable.

```html
<script>     
  var myJsVar = ''; 
</script>
```

The JavaScript variable named `myJsVar` will be the one to receive the data from the PHP variable that we have created in Step 1.

## Step 3: Assign the PHP variable to the JS variable.

```html
<script>     
  var myJsVar = '<?php echo $my_php_var; ?>'; 
</script>
```

The PHP variable containing `Hello World!` is now assigned to our JavaScript variable named `myJsVar`.

## Complete code:

```html
<!DOCTYPE html> 
<html>     
  <?php         
    $my_php_var = 'Hello World!';     
  ?>    
  <script>         
    var myJsVar = '<?php echo $myPHPVar; ?>';    
  </script> 
</html>
```

If you might want to check if the variable `myJsVar` really contains the string `Hello World!`, you can do it using the JavaScript functions `alert()` or `console.log()`. Personally, I would recommend using `console.log()` and see the output in the console.

## Basic usage:

```js
console.log(myJsVar); //Hello World!
```

This should print the string `Hello World!` in the console tab of your debugging tools.

That’s it I hope you have learned something from this tutorial.
