---
categories: ['Website Development']
tags: ['WordPress', 'WordPress Plugin', 'PHP', 'File Upload']
---
In this tutorial, we are going to upload files in WordPress programmatically. Maybe you have already seen PHP File Upload and it simply didn’t work. Even if it does work, it is not recommended to use it.

We are going to create a simple plugin that will allow us to upload files programmatically.

WordPress has already a built-in file uploader which you can use to programmatically upload files. The file uploader is a function called `wp_upload_bits()` which is located in `wp-includes/functions.php`. The files will be uploaded to the `wp-content/uploads/` directory.

## Step 1: Create a plugin file.
This file will be named as `upload.php` and the content as follows:

```php
<?php
/* 
Plugin Name: Upload Files Programatically 
Plugin URI: https://wordpress.org/plugins/ 
Description: Just another file uploader plugin. 
Version: 1.0.0 
Author: David Angulo 
Author URI: https://www.davidangulo.xyz
*/
```

## Step 2: Create a function that will show the file uploader.
Add the following code to the `upload.php` file that we have created earlier.

```php
function myFileUploader() {     
  echo '
    <form action="" enctype="multipart/form-data" method="post">
      <input id="fileToUpload" name="fileToUpload" type="file"> 
      <input name="submit" type="submit" value="Upload File">
    </form>
  '; 
}
```

This form will allow us to show the uploader in the front-end. We have set the `action` attribute to nothing meaning that the same page will be used in processing the form and `enctype="multipart/form-data"` to allow the form to accept files.

## Step 3: Add the function to render our form.

```php
function myFileUploaderRenderer() {     
  ob_start();    
  myFileUploader();     
  return ob_get_clean(); 
}
```

This will show the form to our front-end.

## Step 4: Add a hook for the shortcode to work.
```php
add_shortcode('custom_file_uploader', 'myFileUploaderRenderer');
```

This will register our shortcode for it to be available for use.

## Step 5: Add the PHP code to process our form.
```php
if (isset($_POST['submit'])) {     
  wp_upload_bits($_FILES['fileToUpload']['name'], null, file_get_contents($_FILES['fileToUpload']['tmp_name'])); 
}
```

This is the PHP code that will process our form and should be included in the `myFileUploader()` function.

### Optional 1: Limit the file types that can be accepted.
To limit the file types that can be accepted to our uploader is to add the accept attribute in the input file tag.

```html
<input id="fileToUpload" accept=".doc,.docx,.pdf" name="fileToUpload" type="file">
```

The form will only accept **.doc**, **.docx**, and **.pdf** file formats. You can add or change these file formats to your preference.

### Optional 2: Change the file name on upload.
To change the file name that was saved to the server simply change this line of code.

```php
$my_custom_filename = time() . $_FILES['fileToUpload']['name'];
wp_upload_bits($my_custom_filename , null, file_get_contents($_FILES['fileToUpload']['tmp_name']));
```

This will make the file uploaded to the server named by the current time with the original filename, making it almost impossible to have duplicate file names. You can change it on whatever you want.

### Optional 3: Limit the maximum file size to be uploaded.
We should add an if statement to check the file size before uploading it to the server. Changing the code in step 5 to this will do the trick.

```php
if (isset($_POST['submit'])) {     
  if ($_FILES['fileToUpload']['size'] <= 500000) {         
    wp_upload_bits($_FILES['fileToUpload']['name'], null, file_get_contents($_FILES['fileToUpload']['tmp_name']));     
  } 
}
```

All file larger than **500KB** will not be uploaded. You can also change the maximum file size to your preference.

## Complete code (without optional):
```php
<?php
/*
Plugin Name: Upload Files Programatically
Plugin URI: https://wordpress.org/plugins/
Description: Just another file uploader plugin.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
*/

function myFileUploader() {
  if (isset($_POST['submit'])) {
    wp_upload_bits($_FILES['fileToUpload']['name'], null, file_get_contents($_FILES['fileToUpload']['tmp_name']));
  }
  echo '
    <form action="" method="post" enctype="multipart/form-data">
      <input type="file" name="fileToUpload" id="fileToUpload">
      <input type="submit" value="Upload Image" name="submit">
    </form>
  ';
}

function myFileUploaderRenderer() {
  ob_start();
  myFileUploader();
  return ob_get_clean();
}

add_shortcode('custom_file_uploader', 'myFileUploaderRenderer');
```

## Basic usage:
Make sure that you activate our plugin in your plugins option.

In the WordPress visual editor, you can now use the shortcode `[custom_file_uploader]`.

This must show the file uploader.

The file will be saved in the `wp-content/uploads/year/month` where **year** and **month** is based on the current date.

That’s it, we have now created a WordPress plugin that will allow users to upload files to our server. In any case, you have encountered an error, please review the steps.
