---
categories: ['Website Development']
tags: ['PHP']
---
In this tutorial, I will guide you on how to verify email address in PHP.

Sometimes a regular expression is just not enough. For example, you can contact me through my email address `hello@davidangulo.xyz` and we can have this email `example@davidangulo.xyz` in this case, both of the email addresses will return as valid in regular expression where the second email really does not exist.

This is why most of the websites send a confirmation link to your email to verify if the email address really does exist. So in this tutorial, we would be using PHP to verify the validity of an email address using three (3) stage validation.

**Stage 1: Regular Expression (regex)** – We would be using a regular expression to identify if the format of the input is valid as an email address if it is then we proceed to stage 2, if not then we would return it as an invalid email address.

**Stage 2: Domain Validity** – We would be checking if the domain really exists then if not we cannot consider it as a valid email address.

**Stage 3: SMTP protocol** – We would be simulating a message delivery to the email address to know if it is valid.

## Note:
This will not work on localhost.

If you are on a shared hosting, there are cases that this will not work on Yahoo! email addresses since there are blocked IP addresses from Yahoo!.

## Step 1: Get a copy of `class.verifyEmail.php`
It is a PHP class created by Konstantin Granin that uses SMTP protocol to validate an email address.

You can download it by clicking on [this link](https://www.phpclasses.org/package/6650-PHP-Check-if-an-e-mail-is-valid-using-SMTP.html).

Or you can copy the file from [this link](https://gist.github.com/dcangulo/e733396cf5a4eeb197d7e4a46604c6c6).

## Step 2: Create a PHP page with a form that accepts email address.

```html
<html>
  <head>
    <title>Sample</title>
  </head>
  <body>
    <form action='' method='get'>
      <input type='email' name='email'>
      <button type='submit'>Submit</button>
    </form>
  </body>
</html>
```

A simple form that accepts email address.

## Step 3: Include the class.verifyEmail.php
```php
<html>
  <head>
    <title>Sample</title>
  </head>
  <body>
    <?php
      include_once 'class.verifyEmail.php';
      if (isset($_GET['email'])) {
        $email = $_GET['email'];
        $vmail = new verifyEmail();
        $vmail->setStreamTimeoutWait(20);
        $vmail->Debug = TRUE;
        $vmail->Debugoutput= 'html';
        $vmail->setEmailFrom('viska@viska.is'); //change this email address
        if ($vmail->check($email)) {
          echo 'email ' . $email . ' exist!';
        } 
        elseif (verifyEmail::validate($email)) {
          echo 'email ' . $email . ' valid, but not exist!';
        } 
        else {
          echo 'email ' . $email . ' not valid and not exist!';
        }
      }
    ?>
    <form action='' method='get'>
      <input type='email' name='email'>
      <button type='submit'>Submit</button>
    </form>
  </body>
</html>
```

Include the class file to validate the email address from the form.

That’s it, you have now created a form that validates if the email address is valid or not. I hope you have a good use for it.
