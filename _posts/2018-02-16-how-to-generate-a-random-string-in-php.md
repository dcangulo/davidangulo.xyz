---
categories: ['Website Development']
tags: ['PHP']
title: 'How to generate a random string in PHP'
---
In this tutorial, we would be dealing with `str_repeat`, `str_shuffle`, and `substr` to generate a random string in PHP.

Random strings can be used in generating things that use random strings such as tokens, initial password, and some other things that need to be hard to guess.

## Step 1: Declare the string where you will get your generated random string.
```php
function randomString() {     
  $my_string = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHILJKLMNOPQRSTUVWXYZ0123456789';
  $my_random_string = $my_string;     
  return $my_random_string; 
} 
```

I declared the numbers 0-9 twice to compensate for having both upper and lowercase of letters. We don't want our generated strings to be filled with letters right?

This function will simply return `abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHILJKLMNOPQRSTUVWXYZ0123456789` on the screen which is composed of 73 characters.

## Step 2: Use `str_repeat` to duplicate your initially declared string.
For this example, we used `$my_string` as our declared string.

```php
function randomString() {     
  $my_string = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHILJKLMNOPQRSTUVWXYZ0123456789';     
  $my_random_string = str_repeat($my_string, 10);     
  return $my_random_string; 
} 
```

This function will now return 10 times the length of the returned value from Step 1 which is composed of 730 characters.

## Step 3: Use `str_shuffle` to randomize the position of every character present in `$myString`.
```php
function randomString() {     
  $my_string = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHILJKLMNOPQRSTUVWXYZ0123456789';     
  $my_random_string = str_repeat($my_string, 10);     
  $my_random_string = str_shuffle($my_random_string);     
  return $my_random_string; 
} 
```

The purpose of using `str_repeat` is to add repetitions among the characters. `str_repeat` together with `str_shuffle` to have 2 or more of the same characters in a string.

An example is having "aaa" or "abcddd". If I didn't use the `str_repeat` we can only generate a unique set of characters such as "jkl" but never "jjl".

This function will return a shuffled version of the output in Step 2 and still composed of 730 characters.

## Step 4: Use `substr` to print only the first `n` characters of the string where `n` is your desired number of random characters to be generated.
In this example, we would be generating 10 random characters.
```php
function randomString($n = 10) {     
  $my_string = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHILJKLMNOPQRSTUVWXYZ0123456789';     
  $my_random_string = str_repeat($my_string, 10);     
  $my_random_string = str_shuffle($my_random_string);     
  $my_random_string = substr($my_random_string, 0, $n);     
  return $my_random_string; 
} 
```

This function will return a 10 characters random string. In Step 2, we generated a shuffled version of the 730 characters, but we don't want to have it long like that right? So we used `substr` to limit the length of our output.

You can now copy this function as working code, but if you wish to have an additional feature such as no duplicates, then proceed to Step 5.

## Step 5: Use recursion to check for duplicates. This will not allow our function to return a duplicated string.
```php
function randomString($n = 10) {     
  $my_string = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHILJKLMNOPQRSTUVWXYZ0123456789';     
  $my_random_string = str_repeat($my_string, 10);     
  $my_random_string = str_shuffle($my_random_string);     
  $my_random_string = substr($my_random_string, 0, $n);   

  if($my_random_string has duplicates) {   
    /**
      This is not a valid condition, create your own condition to check for duplicates.
      You can use in_array() function to check for duplicates in a set of array or some other conditions before returning the string.
    */         
    randomString($n);     
  }
  else {         
    return $my_random_string;    
  } 
} 
```

This function will have the same output as we have in Step 4, but the upside of this function is that it will not return a duplicated string. Instead, the output will only be generated once and never again, but you need the right condition for it to work.

## Basic Usage:
```php
echo randomString(); // This will print a 10 characters random string. 
echo randomString(15); // This will print a 15 characters random string. 
```

That's it. We have created a random string generator using PHP.
