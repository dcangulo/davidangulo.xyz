---
categories: ['Website Development']
tags: ['PHP', 'WordPress', 'WordPress Plugin']
---
In this tutorial, we would be dealing with how to create a contact form plugin in WordPress.

There are tons of contact form plugins in the WordPress plugin directory. There are also contact form included in some WordPress themes.

If you are wanting to become one of those developers in the repository then you got to start somewhere.

Also, if you are also the person who don’t want to use plugins in the directory because some of them have the functions that you don’t actually need and it just bloats your website then you can use this tutorial to create your own simple contact form plugin.

## Note:
> This will not work on localhost. (unless you have installed and correctly configured some STMP plugin such as [WP Mail SMTP](https://wordpress.org/plugins/wp-mail-smtp/))

Since we want to show the form using the WordPress WYSIWYG editor then we can create it as a shortcode. You can read more on about shortcodes in [how to create a shortcode tutorial](/posts/how-to-create-custom-wordpress-shortcode-plugin-from-scratch).

## Step 1: Create the plugin header.
Below is the plugin header that we are going to use. Feel free to edit some of the values.

```php
<?php
/*
Plugin Name: Simple Contact Form
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: A very simple contact form.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz
License: GPL2
*/
```

This will make our plugin hooked into the WordPress core.

## Step 2: Create two (2) functions.
```php
function myContactFormRender() {

}

function myContactForm() {

}
```

The function `myContactFormRender()` will render our HTML codes to make sure that it will fit in the theme.

The other function `myContactForm()` will have the form and the PHP code to process the form.

## Step 3: Create a shortcode.
We will hook the `myContactFormRender()` function to be able to use it as a shortcode.

```php
add_shortcode('simple_contact_form', 'myContactFormRender');
```

We will use the shortcode `[simple_contact_form]` to show our contact form.

## Step 4: Create the fields.
We will create fields inside the function `myContactForm()`.

```html
<form action="<?php echo esc_url($_SERVER['REQUEST_URI']);?>" method="post">
    <label for="scf-name">Name:</label><input type="text" class="form-control" id="scf-name" name="scf-name" required>
    <label for="scf-email">Email Address:</label><input type="email" class="form-control" id="csf-email" name="scf-email" required>
    <label for="scf-subject">Subject:</label><input type="text" class="form-control" id="scf-subject" name="scf-subject" required>
    <label for="scf-message">Message:</label><textarea class="form-control" id="scf-message" name="scf-message" rows="5" required></textarea>
    <button class="pull-right" type="submit" id="scf-submit" name="scf-submit">Send</button>
</form>
```

In this example, we are going to have a field for the name, email address, subject and the message of the sender and all of them are required.

We also used the method post to make it more private and action to self since our shortcode also hold the code to process our form.

## Step 5: Create the form processing code.
```php
<?php
if (isset($_POST['scf-submit'])) {
  $name = $_POST['scf-name'];
  $email = $_POST['scf-email'];
  $subject = $_POST['scf-subject'];
  $message = $_POST['scf-message'];
  $to = get_option('admin_email');
  $headers = "From: $name <$email>" . "\r\n";

  if (wp_mail($to,$subject,$message,$headers)) {
    echo '<script>alert("Your message has been sent successfully.");</script>';
  }
  else {
    echo '<script>alert("An error has occured.");</script>';
  }
}
```

We have created a condition where our code will only process the form when the form is actually submitted.

The `$to` variable is assigned in a WordPress function [`get_option()`](https://developer.wordpress.org/reference/functions/get_option/) with a parameter of `admin_email`. This will automatically fetch the email address of the WordPress website.

The [`wp_mail()`](https://developer.wordpress.org/reference/functions/wp_mail/) function behaves likes the built-in PHP [`mail()`](https://www.w3schools.com/php/func_mail_mail.asp) function.

Then the last condition that we have created would be to check whether our contact form really sends our message or not, just for the user to be aware.

## Step 6: Add CSS design.
```html
<style>
  .form-control {
    width: 100%;
    margin-bottom: 20px;
  }
  
  .pull-right {
    float: right;
  }
</style>
```

It is up to you on how you will design your contact form as this two (2) classes above are enough for me.

Take a note that most of the time, it takes the appearance of the theme installed so you don’t have to worry much designing the form.

## Step 7: Connect the two functions.
```php
function myContactFormRender() {
  ob_start();
  myContactForm();
  return ob_get_clean();
}

function myContactForm() {
  //your code in steps 4, 5, and 6
}
```

You may have observed that we created two (2) functions earlier, and this is the time to connect them.

## Complete code:
```php
<?php
/*
Plugin Name: Simple Contact Form
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: A very simple contact form.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
License: GPL2
*/

add_shortcode('simple_contact_form', 'myContactFormRender');

function myContactFormRender() {
  ob_start();
  myContactForm();
  return ob_get_clean();
}

function myContactForm() {
  if (isset($_POST['scf-submit'])) {
    $name = $_POST['scf-name'];
    $email = $_POST['scf-email'];
    $subject = $_POST['scf-subject'];
    $message = $_POST['scf-message'];
    $to = get_option('admin_email');
    $headers = "From: $name <$email>" . "\r\n";
    
    if (wp_mail($to,$subject,$message,$headers)) {
      echo '<script>alert("Your message has been sent successfully.");</script>';
    }
    else {
      echo '<script>alert("An error has occured.");</script>';
    }
  }
  ?>
    <style>
      .form-control {
        width: 100%;
        margin-bottom: 20px;
      }
      
      .pull-right {
        float: right;
      }
    </style>
    <form action="<?php echo esc_url($_SERVER['REQUEST_URI']);?>" method="post">
      <label for="scf-name">Name:</label><input type="text" class="form-control" id="scf-name" name="scf-name" required>
      <label for="scf-email">Email Address:</label><input type="email" class="form-control" id="csf-email" name="scf-email" required>
      <label for="scf-subject">Subject:</label><input type="text" class="form-control" id="scf-subject" name="scf-subject" required>
      <label for="scf-message">Message:</label><textarea class="form-control" id="scf-message" name="scf-message" rows="5" required></textarea>
      <button class="pull-right" type="submit" id="scf-submit" name="scf-submit">Send</button>
    </form>
  <?php
}
```

That’s it, our simple contact form plugin is done. Just activate the plugin that we have created and just simply use the shortcode `[simple_contact_form]` then click Publish.

Happy developing!
