---
categories: ['Website Development']
tags: ['PHP']
title: 'How to abbreviate numbers in PHP'
---
In this tutorial, we would be using a PHP function to abbreviate numbers in PHP. This will convert big numbers such as 1000 to 1K, 1000000 to 1M and so on. This will support up to trillions of numbers.

Do you want to have a shorter version of numbers as seen on the famous website such as YouTube where you notice that their number of views is abbreviated? This is the tutorial for you.

## Step 1: Create your PHP function that accepts a parameter.

```php
function abbreviateNumber($num) { 

}
```

This is a PHP function that accepts a value.

## Step 2: Create a condition for each group.
In this tutorial, I would group the numbers in thousands, millions, billions and trillions. If ever you need a number bigger than trillions you can just simply add another condition.

```php
if ($num >= 0 && $num < 1000) {     
  $format = floor($num);    
  $suffix = ''; 
}
```

If the number is between 0 and 999, I would just simply display the number as it is.

```php
else if ($num >= 1000 && $num < 1000000) {     
  $format = floor($num / 1000);     
  $suffix = 'K+'; 
}
```

But if the number ranges from 1,000 to 999,999 where 999,999 is the last number to be included in the thousands group. I will use the suffix K for thousands.

You will also do this for the other groups.

```php
else if ($num >= 1000000 && $num < 1000000000) {     
  $format = floor($num / 1000000);     
  $suffix = 'M+'; } 
else if ($num >= 1000000000 && $num < 1000000000000) {     
  $format = floor($num / 1000000000);     
  $suffix = 'B+'; 
} 
else if ($num >= 1000000000000) {     
  $format = floor($num / 1000000000000);     
  $suffix = 'T+'; 
}
```

## Step 3: Return the abbreviated number.

```php
return !empty($format . $suffix) ? $format . $suffix : 0;
```

This will now return the abbreviated number of the number that is received in the parameter.

## Complete code:

```php
<?php
function abbreviateNumber($num) {
  if ($num >= 0 && $num < 1000) {
    $format = floor($num);
    $suffix = '';
  } 
  else if ($num >= 1000 && $num < 1000000) {
    $format = floor($num / 1000);
    $suffix = 'K+';
  } 
  else if ($num >= 1000000 && $num < 1000000000) {
    $format = floor($num / 1000000);
    $suffix = 'M+';
  } 
  else if ($num >= 1000000000 && $num < 1000000000000) {
    $format = floor($num / 1000000000);
    $suffix = 'B+';
  } 
  else if ($num >= 1000000000000) {
    $format = floor($num / 1000000000000);
    $suffix = 'T+';
  }
  
  return !empty($format . $suffix) ? $format . $suffix : 0;
}
```

## Basic usage:
```php
echo abbreviateNumber(89); //89 
echo abbreviateNumber(215867); //215K+ 
echo abbreviateNumber(1500236); //1M+ 
echo abbreviateNumber(10123456789); //10B+ 
echo abbreviateNumber(1987654321001); //1T+
```

This will be the output of the following input where the output is commented on each line.

That’s it, we have now created a PHP function that will allow us to convert big numbers to the abbreviated one.
