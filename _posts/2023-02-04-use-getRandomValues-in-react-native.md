---
categories: ['Mobile App Development']
tags: ['React Native', 'Expo', 'polyfill']
title: 'Use getRandomValues in React Native'
---
If you have been coding React Native for a while you may have noticed that some of Web APIs aren't implemented in React Native.

One useful Web API that can be nice to have is [`Crypto.getRandomValues()`](https://developer.mozilla.org/en-US/docs/Web/API/Crypto/getRandomValues). It allows us to generate cryptographically secure random values.

## Why do we need it?
```js
const array = new Uint32Array(3);
crypto.getRandomValues(array);
console.log(array); // Uint32Array(3) [910455739, 2479945565, 2186657619, buffer: ArrayBuffer(12), byteLength: 12, byteOffset: 0, length: 3, Symbol(Symbol.toStringTag): 'Uint32Array']
```

On web the code would simply fill `array` with cryptographically secure random values and logs the array together with the values generated, but on React Native this will throw an error `Can't find variable: crypto`.

Also, some libraries like [uuid](https://www.npmjs.com/package/uuid) depends on this API. If you ever to use some libraries that depend on this API you will need the polyfill.

```js
import { v4 as uuidv4 } from 'uuid';
const uuid = uuidv4();
```

The above code will throw `crypto.getRandomValues() is not supported` in React Native.

## The Polyfill
That's where [react-native-get-random-values](https://github.com/LinusU/react-native-get-random-values) saves us. It defines the function `crypto.getRandomValues` so that we can work on our React Native project just like on how we work on web.

We can just install the polyfill.
```console
$ yarn add react-native-get-random-values
```

Run the next command if you're also supporting iOS.
```console
$ npx pod-install ios
```

Since this module contains native code, you need to rebuild your project.

Then in your `index.js`:
```js
import 'react-native-get-random-values';
import { AppRegistry } from 'react-native';
// ... your other codes
```
{: file='index.js' }

After this, errors such as `Can't find variable: crypto` and `crypto.getRandomValues() is not supported` should now disappear.

That's it, we now have successfully installed a polyfill to be able to work with JavaScript libraries that depends on Web API to work with React Native.
