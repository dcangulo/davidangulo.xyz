---
categories: ['Mobile App Development']
tags: ['React Native', 'react-native-windows', 'react-native-macos', 'polyfill']
title: 'Use URL class in React Native'
---
If you have been coding React Native for a while you may have noticed that some of Web APIs aren't implemented in React Native.

One Web API that I commonly use is the [URL interface](https://developer.mozilla.org/en-US/docs/Web/API/URL), it allows us to parse a URL, read, and modify them.

## Why do we need it?
An example would be reading a query params from the URL.

In a normal scenario we would treat a URL simply as string:
```js
const url = 'https://davidangulo.xyz/?param1=value1&param2=value2';
const params = url.split('?')[1].split('&'); // ['param1=value1', 'param2=value2']
const param1 = params[0].split('=')[1]; // value1
const param2 = params[1].split('=')[1]; // value2
```

This method gets dirty and error-prone fast when we can just URL interface to simplify this for us.
```js
const url = new URL('https://davidangulo.xyz/?param1=value1&param2=value2');
const param1 = url.searchParams.get('param1'); // value1
const param2 = url.searchParams.get('param2'); // value2
```

The thing is there is a URL class in React Native but not all feature are implemented which you might encounter a `is not implemented error` such as `URLSearchParams.set is not implemented`, `URL.hostname is not implemented`, etc.

They are defined in [https://github.com/facebook/react-native/blob/main/Libraries/Blob/URL.js](https://github.com/facebook/react-native/blob/main/Libraries/Blob/URL.js).

## The Polyfill
That's where [react-native-url-polyfill](https://github.com/charpeni/react-native-url-polyfill) saves us. It allows us to use all URL interface features.

The following code will show `Error: URLSearchParams.get is not implemented, js engine: hermes` without the polyfill.
```js
const url = new URL('https://davidangulo.xyz/?param1=value1&param2=value2');
const param1 = url.searchParams.get('param1'); // value1
const param2 = url.searchParams.get('param2'); // value2
```

To fix the error we can just install the polyfill.
```console
$ yarn add react-native-url-polyfill
```

Then in your `index.js`:
```js
import 'react-native-url-polyfill/auto';
import { AppRegistry } from 'react-native';
// ... your other codes
```
{: file='index.js' }

After this the `Error: URLSearchParams.get is not implemented, js engine: hermes` should now disappear.

If you don't want to globally override URL class the module offers other methods of usage you may read it on the [module's documentation](https://github.com/charpeni/react-native-url-polyfill#readme).
