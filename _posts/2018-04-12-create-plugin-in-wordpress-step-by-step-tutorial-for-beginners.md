---
categories: ['Website Development']
tags: ['MySQL', 'PHP', 'SVN', 'WordPress', 'WordPress Plugin']
---
This tutorial will guide you on how to create plugin in WordPress.

WordPress plugins are simply PHP scripts that extend the functionality of your WordPress website. If you have a running WordPress website and you need to add some functionality you can always rely on the wordpress plugin directory, this enables you to add functionality to your website without the need to learn on how to code.

But, what if the functionality that you are looking for is not available? If you are a developer, then you need to write the code yourself and if you are generous enough you will make the plugin flexible, meaning it can be installed and it is compatible with all WordPress websites. If you are non-developer then you might need to hire a developer to do it for you or instead search for an alternative plugin that suits your needs.

## Step 1: Create a folder.
You will need to create a folder with the folder name as your plugin name. Then put this folder in the `wp-content/plugins` directory.

In this tutorial, we will name the folder as `mysuperbplugin`.

## Step 2: Create a PHP file.
The PHP file must be inside the folder that you have created and for this tutorial, we will name it as `mysuperbplugin.php`.

The content of `mysuperbplugin.php` is as follows:

```php
<?php
/*
Plugin Name: My Superb Plugin
Plugin URI: https://www.davidangulo.xyz/portfolio/
Description: A very superb plugin.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
License: GPL2
*/
```

The content above will be the description of your plugin. This is a standard format and you can add more information if you want.

If you navigate to your plugins, you should see **My Superb Plugin** in the list. You might want to activate your plugin now even though it does not have any function just yet.

## Step 3: Plan your plugin functionality.
Ask yourself, what should your plugin do? There are tons of plugins in the WordPress directory and if you are planning to include yours in that list you must create something unique.

Plugins can be a simple such as printing a text to complex such as having an e-commerce plugin or reservation plugin. Each plugin has their own functionalities.

I will just list some functionalities and example plugins that can guide you on how to create plugin in WordPress.

### a. Admin Page

![admin](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/admin.jpg)

*a. An admin page.*

Most of the big plugins use this functionality. Since their plugins offer a wide range of options and configurations they will need to create a user interface for users to easily use their plugin.

A plugin that uses an **Admin Page** is [**Simple Author Box**](https://wordpress.org/plugins/simple-author-box/).

Read: [How to create an admin page for your WordPress plugin](/posts/how-to-create-an-admin-page-for-your-wordpress-plugin/)

### b. Sub-menu Page

![submenu](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/submenu.jpg)

*b. A sub-menu page..*

If one page is not enough then you need to add more pages for your plugin. This will add a child menu on the Admin page.

A plugin that uses **Sub-menu** Page is [**Yoast SEO**](https://wordpress.org/plugins/wordpress-seo/).

Read: [How to add submenu in WordPress custom plugin](/posts/how-to-add-submenu-in-wordpress-custom-plugin/)

### c. Settings Page

![settings](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/settings.jpg)

*c. A settings page.*

Some plugin needs to be configured to the settings to let the users pick the functions that they want to enable and disable. The settings page allows your plugin to save settings in the WordPress that you can use.

A plugin that uses **Settings Page** is [**WP Mail SMTP**](https://wordpress.org/plugins/wp-mail-smtp/).

Read: [How to create a settings page for your WordPress plugin](/posts/how-to-create-a-settings-page-for-your-wordpress-plugin/)

### d. Dashboard Widget

![dashboard-widget](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/dashboard-widget.jpg)

*d. A dashboard widget.*

Dashboard widgets are the content that you see in WordPress admin dashboard. This is the first page that an admin will see whenever he login. This is a good functionality used for a summary of reports.

A plugin that uses **Dashboard Widget** is [**Wordfence**](https://wordpress.org/plugins/wordfence/).

Read: [How to create a dashboard widget in WordPress](/posts/how-to-create-a-dashboard-widget-in-wordpress/)

### e. Shortcode

![shortcode](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/shortcode.jpg)

*e. A login form shortcode.*

A shortcode is a text that you can use in WordPress WYSIWYG editor to show some functionality. An example is when you have created a form using HTML, you can register it using the shortcode and this shortcode will be used in the editor for the form that you have created to appear.

A plugin that uses **Shortcode** is [**Separate Login Form**](https://wordpress.org/plugins/separate-login-form/).

Read: [How to create custom WordPress shortcode plugin from scratch](/posts/how-to-create-custom-wordpress-shortcode-plugin-from-scratch/)

### f. Upload Files

![upload](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/upload.jpg)

*f. A file uploader plugin.*

If you are developing a plugin that needs to upload files then you can use this functionality. All files uploaded using this uploader will be uploaded to `wp-content/uploads` directory.

Read: [How to upload files in WordPress programmatically](/posts/how-to-upload-files-in-wordpress-programmatically/)

### g. Posts Custom Column

![custom-column](/assets/images/posts/create-plugin-in-wordpress-step-by-step-tutorial-for-beginners/custom-column.jpg)

*g. A custom last modified date column.*

Whenever you navigate to *All Posts*, you can see the list in a table. If you are developing a plugin that is specific for posts, then you can add a custom column generated by your plugin. Maybe you want to create a plugin that allows users to rate each post and the summary will be listed in the custom column.

A plugin that uses **Posts Custom Column** is [**Posts Unique View Counter**](https://wordpress.org/plugins/posts-unique-view-counter/).

Read: [How to add custom column in WordPress post](/posts/how-to-add-custom-column-in-wordpress-post/)

### h. Custom Database Tables
Sometimes, your plugin just needs a database to store its data. This will allow your plugin to automatically creates database tables when activated where the tables you have created can be used to perform database operations.

A plugin that uses **Custom Database Tables** is [**Caldera Forms**](https://wordpress.org/plugins/caldera-forms/).

Read: [How to create database tables when your plugin is activated](/posts/how-to-create-database-tables-when-your-plugin-is-activated/)

### i. Cron Jobs
Cron jobs are actions that are automatically executed every a specific interval. If you are creating that needs to do something automatically then you this functionality will fit your plugin.

The WordPress itself uses cron jobs.

A plugin that uses **Cron Jobs** is [**WP Crontrol**](https://wordpress.org/plugins/wp-crontrol/).

Read: [How to create  cron job in WordPress](/posts/how-to-create-cron-job-in-wordpress/)

---

So have you got any idea of what your plugin needs to do? You can always refer to look for a non-existent plugin and create them or innovate some plugins that need have additional functionalities.

Here are some plugins that have a step by step tutorial for beginners.

### a. CRUD Operations Plugin (Step by Step tutorial)
This is a simple plugin that can do crud(create/read/update/delete) operations. You can refer to this tutorial to have a better understanding of WordPress database operations.

Read: [How to create CRUD operations plugin in WordPress](/posts/how-to-create-crud-operations-plugin-in-wordpress/)

### b. Contact Form Plugin (Step by Step tutorial)
This is a simple plugin that allows you to put a contact form on any page/post that you want and this tutorial will guide you on how to create it.

Read: [How to create a contact form plugin in WordPress](/posts/how-to-create-a-contact-form-plugin-in-wordpress/)

## Step 4: Upload your plugin.
If you have successfully created your own plugin, then it is time to upload it to the WordPress plugin directory. This will allow your plugin to be open for use in public.

Read: [How to upload your plugin to WordPress plugin directory](/posts/how-to-upload-your-plugin-to-wordpress-plugin-directory/)

That’s it, I hope you are able to create plugin in WordPress.
