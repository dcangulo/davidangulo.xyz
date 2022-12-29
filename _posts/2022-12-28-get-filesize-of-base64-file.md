---
categories: ['General Programming']
tags: ['base64', 'Ruby', 'JavaScript']
title: 'Get the filesize of base64 file'
---
In the previous post, we have learned to [attach a base64 file on ActiveStorage in Rails](/posts/attach-base64-file-on-activestorage-rails).

The another dilemma that I have encountered is how to validate the filesize of the uploaded files that are encoded in base64.

Lucky for us that there is a simple formula to get the filesize of a base64 file in bytes.

## The formula
```text
a = (b * (3 / 4)) - c
```

### Where:
* `a` is the filesize in bytes.
* `b` is the base64 string length.
* `c` is the base64 string padding `=` length. (if your string ends with `=` then `c` is `1`, if it ends with `==` then `c` is `2`)

## Ruby implementation
```ruby
def file_size_in_bytes(base64)
  base64_string = base64.delete('=')
  bytes = base64_string.length * (3 / 4.to_f)

  bytes.to_i
end
```

What we did in the Ruby implementation was instead of getting the length of `c`, we simplified this by omitting the padding from the base64 string. We subtract it anyway.

A `char` is equal to `1` byte. So it does not matter how many paddings are there, this makes our function more dynamic.

## JavaScript implementation
```js
function fileSizeInBytes(base64) {
  const base64String = base64.replaceAll('=', '');
  const bytes = base64String.length * (3 / 4);

  return bytes;
}
```

Just like in the Ruby implementation, we also omitted the base64 paddings. And then, we can use the formula as is.

We can now use the functions above to validate the filesize of a base64 file.
