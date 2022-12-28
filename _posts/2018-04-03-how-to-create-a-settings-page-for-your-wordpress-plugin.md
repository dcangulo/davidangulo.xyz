---
categories: ['Website Development']
tags: ['PHP', 'WordPress', 'WordPress Plugin']
title: 'How to create a settings page for your WordPress plugin'
---
In this tutorial, we would be learning on how to create a settings page for your WordPress plugin.

Whether the plugin that we are creating is small or big, sometimes we just need a setting for it. It can be from asking a user to pick between yes or no, it also can be asking for a data such as a name or an email address.

This tutorial will guide you on how to do it in your WordPress plugin.

## Step 1: Setup the hook for your settings page.

```php
add_action('admin_menu', 'registerOptionPage');

function registerOptionPage() {
  add_options_page('Plugin Name', 'Plugin Name', 'manage_options', 'myPluginSettings', 'optionPageContent');
}

function optionPageContent() {

}
```

We need the hook to add our plugin in the settings options. This will add the **Plugin Name** if you hover to the settings in your admin side menu.

You can change the **Plugin Name** to the name of your plugin but for this example, we will just keep it as it is. The function `optionPageContent()` will have the content or user interface of your settings page, this includes HTML and CSS.


## Step 2: Add the settings for your plugin.
```php
<?php
function optionPageContent() {
?>
  <h2>Plugin Name</h2>
  <p>These are the settings for your plugin.</p>
  <form method="post" action="options.php">
    <?php
      settings_fields("myPluginSettings");
    ?>
    <table class="form-table">
      <tbody>
        <tr>
          <th>Setting 1</th>
          <td>
            <input type="text" name="setting1" id="setting1" value="<?php echo get_option('setting1');?>"><br><span class="description"> Enter your description for the setting 1 here.</span>
          </td>
        </tr>
        <tr>
          <th>Setting 2</th>
          <td>
            <input type="text" name="setting2" id="setting2" value="<?php echo get_option('setting2');?>"><br><span class="description"> Enter your description for the setting 2 here.</span>
          </td>
        </tr>
      </tbody>
    </table>
    <?php
      submit_button();
    ?>
</form>
<?php
}
```

Here are some HTML tags you are familiar with to create the user interface for your plugin settings page.

We have created a form that will be processed by `options.php` as this file contains all the settings in your WordPress website. This includes the default settings and some settings from your installed plugins. You can also consider this as a master list of the settings.

We also need to define the [`settings_field()`](https://codex.wordpress.org/Function_Reference/settings_fields) so that WordPress will be able to identify each setting uniquely. I recommend that you use your plugin name plus the word settings in the parameter.

To view your settings you will just use the [`get_option()`](https://developer.wordpress.org/reference/functions/get_option/) function. This is not only available for your own settings but also you can use it to retrieve settings from the default list such as `admin_email`. You can see all options in the `options.php`, where using `get_option()` allows you to use whatever the data you need.

## Step 3: Register the plugin settings.
If you tried opening the options.php in Step 2. You will notice that our settings are still not listed there because it is not yet registered in the settings.

To register it, you need to add another hook to register the settings.

```php
add_action('admin_init', 'registerPluginSettings');

function registerPluginSettings() {
  register_setting('myPluginSettings', 'setting1');
  register_setting('myPluginSettings', 'setting2');
}
```

The [`register_setting()`](https://developer.wordpress.org/reference/functions/register_setting/) function will register your settings. The first parameter is the same as `settings_field()` in Step 2. This is to identify where are these settings used, so in this case, it is identified that our plugin is the one registered and uses this setting. While on the second parameter is the name of the setting, make sure it matches the name and the id of the fields in Step 2.

You can retrieve your settings by using the `get_option()` function with your setting name as the parameter.

## Complete Code:
```php
<?php
/*
Plugin Name: WordPress plugin with settings
Plugin URI: wordpress.org/plugins
Description: Just another WordPress plugin with settings page.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/wp/
License: GPL2
*/

add_action('admin_menu', 'registerOptionPage');

function registerOptionPage() {
  add_options_page('Plugin Name', 'Plugin Name', 'manage_options', 'myPluginSettings', 'optionPageContent');
}

function optionPageContent() {
?>
<h2>Plugin Name</h2>
<p>These are the settings for your plugin.</p>
<form method=post" action="options.php">
  <?php
    settings_fields('myPluginSettings');
  ?>
  <table class="form-table">
    <tbody>
      <tr>
        <th>Setting 1</th>
        <td>
          <input type="text" name="setting1" id="setting1" value="<?php echo get_option('setting1');?>"><br><span class="description"> Enter your description for the setting 1 here.</span>
        </td>
      </tr>
      <tr>
        <th>Setting 2</th>
        <td>
          <input type="text" name="setting2" id="setting2" value="<?php echo get_option('setting2');?>"><br><span class="description"> Enter your description for the setting 2 here.</span>
        </td>
      </tr>                    
    </tbody>
  </table>
  <?php 
    submit_button();
  ?>
</form>
<?php
}

add_action('admin_init', 'registerPluginSettings');

function registerPluginSettings() {
  register_setting('myPluginSettings', 'setting1');
  register_setting('myPluginSettings', 'setting2');
}
```

That’s it, you have now added settings for your WordPress plugin.
