---
categories: ['Website Development']
tags: ['base64', 'JavaScript']
title: 'Convert Blob to base64 in JavaScript'
---
I usually pass files as base64 string to my REST APIs to upload them.

Here is my go to utility function that converts blob to base64.

```js
function base64FromBlob(blob) {
  return new Promise((resolve, reject) => {
    const fileReader = new FileReader();

    fileReader.addEventListener('load', () => resolve(fileReader.result));
    fileReader.addEventListener('error', reject);
    fileReader.readAsDataURL(blob);
  });
}
```

I simply created a function that returns a `promise` that can either `resolve` or `reject` depends on the result of `fileReader.readAsDataURL`.

`FileReader` is commonly used to asynchronously read contents of a file, can be either an instance of `File` or `Blob`.

`readAsDataURL` allows us to get the `File` or `Blob`'s data URI scheme which would contain our base64 string.

That’s it, we now have a utility function that converts blob to base64.
