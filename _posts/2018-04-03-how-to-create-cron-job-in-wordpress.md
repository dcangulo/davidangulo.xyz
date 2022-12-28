---
categories: ['Website Development']
tags: ['Cron', 'PHP', 'WordPress', 'WordPress Plugin']
title: 'How to create a cron job in WordPress'
---
In this tutorial, we would be learning how to create cron job in WordPress.

Sometimes you just need some automated functions in your WordPress plugins. Maybe you need to generate a report every 12 hours and you need to do this automatically, this is the function that you need to make this possible.

Did you know that wp-cron is different from the cron jobs offered by your hosting provider? Cron jobs in your hosting provider are more reliable than using wp-cron. Cron jobs execute exactly with the time you have set while in wp-cron you need someone to view your site for it to activate. But if you are at least having one (1) visit in your WordPress website then wp-cron should work.

## Step 1: Setup the hook name for the action.
The hook name will be the name for your wp-cron. I’ll give you some example hook name just in case you don’t have any idea. If you are generating reports then you can name your hook name as `generate_reports`.

In this example we would just be using some generic hook name such as `my_daily_event`.

```php
function register_schedule() { 
  if (!wp_next_scheduled('my_daily_event')) { 
    wp_schedule_event(strtotime('06:00:00'), 'daily', 'my_daily_event'); 
  } 
}

register_activation_hook(__FILE__, 'register_schedule'); 
```

The use of [`register_activation_hook`](https://codex.wordpress.org/Function_Reference/register_activation_hook) is when the plugin is activated it will add our wp-cron to the list of cron events.

In the [`wp_schedule_event`](https://codex.wordpress.org/Function_Reference/wp_schedule_event) we have used `strtotime('06:00:00')` and `daily`, this is in 24-hour format, which means our wp-cron will be executed **every day at 06:00 AM**.

On the first parameter, you can set any time you want and you can also use the `time()` function. The `time()` function is more reliable when creating a wp-cron that executes many times a day.

On the second parameter, you can pick from the default options from WordPress, you can select **hourly** (executes once per hour), **twicedaily** (executes every 12 hours), and **daily** (executes once a day). But if you want to add to add more option in these, I will show you how later.

## Step 2: Create the function to be executed.
We will be creating the function that will be executed for our wp-cron.

```php
function do_this_daily() {    
  wp_mail('some.email@example.xyz', 'Morning Message', 'Good Morning! Have a nice day. :)'); 
}

add_action('my_daily_event', 'do_this_daily'); 
```

In this case, our wp-cron will send a good morning email message to **some.email@example.xyz** every day at **06:00 AM**.

Just put inside the function the codes you want to be executed automatically.

## Step 3: Add a deactivation hook.
In Step 1 we have created an activation hook which executes when the plugin activates.

We need this to remove our hook when the plugin deactivates, which means it will stop from auto executing.

```php
function remove_schedule() { 
  wp_clear_scheduled_hook('my_daily_event'); 
}

register_deactivation_hook(__FILE__, 'remove_schedule'); 
```

## Step 4: Add a custom cron schedule.
Just incase you want to have a wp-cron that runs on a specific interval that is not available in the default options.

```php
function custom_cron_schedules($schedules) {
  if (!isset($schedules['5minutes'])) {
    $schedules['5minutes'] = array(
      'interval' => 5*60,
      'display' => __('Once every 5 minutes'));
  }

  if (!isset($schedules['halfhour'])) {
    $schedules['halfhour'] = array(
      'interval' => 30*60,
      'display' => __('Once every 30 minutes'));
  }

  return $schedules;
}

add_filter('cron_schedules', 'custom_cron_schedules');
```

If we add the code above, it will add **5minutes** and halfhour to the list of cron schedules. Meaning, at this point we already have five (5) cron schedules they are **hourly**, **twicedaily**, **daily**, **5minutes**, and **halfhour**. You can change the name to your preference and you can add more to the list.

Just take note that interval is expressed in seconds so we have to multiply the number of minutes by 60.

So if you are going to run a function every 5 minutes then you can simply just change **daily** to **5minutes**.

## Complete code:
```php
<?php
/*
Plugin Name: My cron WordPress plugin
Plugin URI: wordpress.org/plugins
Description: A simple WordPress plugin that executes many times in a certain interval.
Version: 1.0.0
Author: David Angulo
Author URI: https://www.davidangulo.xyz/
License: GPL2
*/

register_activation_hook( __FILE__, 'register_schedule');

function register_schedule() {
  if (!wp_next_scheduled('my_daily_event')) {
    wp_schedule_event(strtotime('06:00:00'), 'daily', 'my_daily_event');
  }
}

add_action('my_daily_event', 'do_this_daily');

function do_this_daily() {
  wp_mail('some.email@example.xyz', 'Morning Message', 'Good Morning! Have a nice day. :)');
}

register_deactivation_hook( __FILE__, 'remove_schedule');

function remove_schedule() {
  wp_clear_scheduled_hook('my_daily_event');
}

add_filter('cron_schedules', 'custom_cron_schedules');

function custom_cron_schedules($schedules) {
  if (!isset($schedules['5minutes'])) {
    $schedules['5minutes'] = array(
      'interval' => 5*60,
      'display' => __('Once every 5 minutes'));
  }
  if (!isset($schedules['halfhour'])) {
    $schedules['halfhour'] = array(
      'interval' => 30*60,
      'display' => __('Once every 30 minutes'));
  }
  return $schedules;
}
```

Since this is a WordPress plugin, we must put this file in the plugin directory of our WordPress website.

There is a plugin that I recommend and use, it is named as [WP Crontrol by John Blackbourn & contributors](https://wordpress.org/plugins/wp-crontrol/). It will show all the wp-cron events in detailed format which includes the hook name, the name of the function that executes, what time it executes and it even allows you to run a wp-cron manually. You can also add cron schedules without any coding.

That’s it, we have now created a wp-cron that executes automatically. I hope you have learned something.
