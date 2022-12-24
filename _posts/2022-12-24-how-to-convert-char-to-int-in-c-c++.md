---
categories: ['General Programming']
tags: ['C', 'C++']
title: 'How To Convert Char To Int in C/C++'
---
I have encountered a problem when taking CS50's Problem Set 1 where I need to convert a `char` number to `int`.

Luckily there is an easy and clever way to do that.

## char_to_int function

```c
int char_to_int(char character) {
  return character - '0';
}
```

The snippet above is a simple C/C++ function that takes `char` number and returns an `int` version of it.

So, how does it work?

## Here is a part of the ASCII table.

| Decimal | Character |
|---------|-----------|
| 48      | 0         |
| 49      | 1         |
| 50      | 2         |
| 51      | 3         |
| 52      | 4         |
| 53      | 5         |
| 54      | 6         |
| 55      | 7         |
| 56      | 8         |
| 57      | 9         |

See full ASCII table at: [https://www.cs.cmu.edu/~pattis/15-1XX/common/handouts/ascii.html](https://www.cs.cmu.edu/~pattis/15-1XX/common/handouts/ascii.html)

It seems like each character has a decimal equivalent. If we use `-` on a `char` it uses the `decimal` equivalent to compute it.

So when we want to convert `'8'` to `8` and called `char_to_int('8')`, what actually happens to `'8' - '0'` is `56 - 48` which results into `8`.

Another example would be `'3'` to `3` where it is interpreted as `51 - 48` which coincidentally equal to `3`.

## Note:
This only works with `char` and not `string` such as `'14'`.

That’s it for this topic. I hope you have a good use for it.
