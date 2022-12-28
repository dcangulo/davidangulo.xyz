---
categories: ['Website Development']
tags: ['WordPress', 'WordPress Plugin']
title: 'How to create a separate login page in WordPress'
---
In this tutorial, I will show you how to create a separate login page in WordPress.

We all know that if you are running a WordPress website is that your admin login page is always known since it is just the same for everybody. If you want to have a login page aside from the default one is you have come to the right place.

There are tons of themes available for WordPress and some of them include a page builder where you can easily create a beautiful page and the upside of that is you can put a login form in your customized page whether it is for public use or for own personal preference.

## Step 1: Install the Separate Login Form plugin.
You may download the plugin by clicking on [this link](https://wordpress.org/plugins/separate-login-form/).

Or if you want to directly install it, you can hover to **Plugins** in your sidebar menu, then click **Add New**.

On the search box, you may type **“Separate Login Form”** or **“David Angulo”**. Make sure to install the plugin **Separate Login Form** and it is authored by **David Angulo**.

![add-plugin](/assets/images/posts/how-to-create-a-separate-login-page-in-wordpress/add-plugin.jpg)

*Picture 1.1. Installing the Separate Login Form plugin by David Angulo.*

## Step 2: Activate the Separate Login Form plugin.
Click the **Plugins** in your sidebar menu, if your installation succeeds then you should see the **Separate Login Form** plugin in the list. Click **Activate** if it is not activated yet.

![activate-plugin](/assets/images/posts/how-to-create-a-separate-login-page-in-wordpress/activate-plugin.jpg)

*Picture 2.1. Activating the Separate Login Form plugin by David Angulo.*

## Step 3: Create a page.
This will be your separate login page.

You can do this by hovering your cursor to **Pages** then click **Add New**.

You may name the page anything you want. But for this tutorial, I will name the page as **Login**.

On the content box, paste the following shortcode.

```txt
[separate_login_form]
```

This shortcode contains your login form. It will be up to you on how you will design your page.

![use-shortcode](/assets/images/posts/how-to-create-a-separate-login-page-in-wordpress/use-shortcode.jpg)

*Picture 3.1. Creating a login page.*

## Step 4: Publish the page.
Click the **Publish** button if you are contented with your editing.

Since we have used **Login** as our title, then we may now access our separate login page on `yourdomain.com/login`.

![result](/assets/images/posts/how-to-create-a-separate-login-page-in-wordpress/result.jpg)

*Picture 4.1. Published login page output.*

## Note:
This page will be inaccessible if someone is already logged in. To test it, you may use another browser or log out on your WordPress website and navigate to the same page again.

That’s it, we have created a separate login page for your WordPress website. I hope you have a good use for this plugin as I have developed it myself. Please rate and review it, if you find it useful.
