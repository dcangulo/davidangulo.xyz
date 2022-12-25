---
categories: ['Website Development']
tags: ['PHP']
---
In this tutorial, we will be learning on how to convert timestamp to time ago in PHP.

Most of you have noticed that the famous social networking site Facebook uses the time ago instead of posting the original timestamp.

Time ago is calculated based on the difference between the current time and date to the actual post time and date.

We will use a PHP function that has a parameter that accepts a timestamp it will return it in time ago format based on your server time.

## Step 1: Get a copy of the following PHP function.
```php
<?php
function timeago($datetime, $full = false) {
  date_default_timezone_set('Asia/Manila');
  $now = new DateTime;
  $ago = new DateTime($datetime);
  $diff = $now->diff($ago);
  $diff->w = floor($diff->d / 7);
  $diff->d -= $diff->w * 7;
  $string = array(
    'y' => 'yr',
    'm' => 'mon',
    'w' => 'week',
    'd' => 'day',
    'h' => 'hr',
    'i' => 'min',
    's' => 'sec',
  );

  foreach ($string as $k => &$v) {
    if ($diff->$k) {
      $v = $diff->$k . ' ' . $v . ($diff->$k > 1 ? 's' : '');
    } 
    else {
      unset($string[$k]);
    }
  }
  
  if (!$full) {
    $string = array_slice($string, 0, 1);
  }
  
  return $string ? implode(', ', $string) . '' : 'just now';
}
```

The original source of the PHP function can be found on [this thread](https://stackoverflow.com/questions/1416697/converting-timestamp-to-time-ago-in-php-e-g-1-day-ago-2-days-ago). It is answered by [Glavić](https://stackoverflow.com/users/67332/glavi%C4%87) on September 3, 2013.

The PHP function accepts any supported date and time format. It does not only return the time ago but also gave you the privilege to return the full exact time ago. You will understand this in the later part.

## Step 2: Use the PHP function.
You will be able to use the function by calling the function name. This function can either accept one (1) or two (2) parameters where the first parameter must be a valid timestamp/datetime and the second one is a boolean(true/false).

Using the true on the boolean parameter makes it return the whole time ago.

Assuming that the current time and date is exactly **2018-04-13 11:46:58**

```php
echo timeago("2018-02-12 02:07:42"); // 2 mons
echo timeago("2018-03-12 02:07:42", true); // 2 mons, 1 day, 17 hrs, 39 mins, 16 secs
```

That’s it if you want to change the suffixes of the numbers you can do so by editing them in the $string variable in the function above.

Don’t forget to add the word ago if you really need it.
