---
categories: ['Website Development']
tags: ['PHP']
---
In this tutorial, we will learn to resize an image in PHP.

Whenever you are doing something like a CMS for your website that requires an image to be uploaded then you can have a problem where users upload images in different dimensions.

This can be a problem in the front-end as your design will not be the same for all.

This is why we need to learn to resize an image in PHP. As long as the file is on the server then you can use this method to resize your images.

This can also be used to resize an image on upload meaning after uploading the original image it will automatically be resized after uploading.

## Step 1: Get a copy of this PHP function.
```php
<?php
function resizeImage($filename, $newwidth, $newheight) {
  list($width, $height) = getimagesize($filename);
  if (pathinfo($filename, PATHINFO_EXTENSION) == 'jpg' || pathinfo($filename,PATHINFO_EXTENSION) == 'jpeg') {
    $src = imagecreatefromjpeg($filename);
    $dst = imagecreatetruecolor($newwidth, $newheight);
    imagecopyresampled($dst, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
    imagejpeg($dst, $filename, 100);
  }

  if (pathinfo($filename,PATHINFO_EXTENSION) == 'png') {
    $src = imagecreatefrompng($filename);
    $dst = imagecreatetruecolor($newwidth, $newheight);
    imagecopyresampled($dst, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
    imagepng($dst, $filename, 0);
  }

  if (pathinfo($filename,PATHINFO_EXTENSION) == 'gif') {
    $src = imagecreatefromgif($filename);
    $dst = imagecreatetruecolor($newwidth, $newheight);
    imagecopyresampled($dst, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
    imagegif($dst, $filename, 100);
  }
}
```
The PHP function accepts three (3) parameters. The first parameter is a string which has the filename of the image that is going to be resized. The second parameter is an integer, this will be the new width of your image. The third and last parameter is also an integer, this will be the new height of your image.

## Step 2: Use the PHP function.

![initial](/assets/images/posts/how-to-resize-an-image-in-php/initial.jpg)

*Picture 2.1. Our sample image laptop.jpg having a dimension of 1920×1280.*

In this example, we are going to have an image laptop.jpg which has a dimension of **1920×1280** and we will want to downscale this image to the quarter of its original size (**480×320**).

Now, the second file that we are going to have is `resize.php` that contains the function above and this file will also make the resizing possible.

Since the filename of our sample image is `laptop.jpg` and it is also in the same directory then we can use the function as follows.

```php
resize_image('laptop.jpg', 480, 320);
```

After executing the file `resize.php` we can see now that our image has lesser file size and has a lower dimension.

![result](/assets/images/posts/how-to-resize-an-image-in-php/result.jpg)

*Picture 2.2. Our sample image laptop.jpg having a new dimension of 480×320.*


That’s it, we have now successfully resized an image in PHP.

You may notice that whenever you use PHP file upload, the file will be uploaded to the server. After a successful upload, just call the function after the file has been uploaded for it to be resized.
