---
categories: ['Mobile App Development']
tags: ['React Native', 'Expo', 'polyfill', 'css']
title: 'Use react-responsive in React Native'
---
If you have been coding React Native for a while you may have noticed that some of Web APIs aren't implemented in React Native.

If you also have been developing web apps using React you might have encountered [`react-responsive`](https://github.com/yocontra/react-responsive). It gives us the power to hook media queries onto our React components.

The library have been utilizing [`Window.matchMedia()`](https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia) under the hood in matching media query string. However, in React Native `matchMedia` is not supported.

## The Polyfill
Lucky for us is that there is already a module that implements a `matchMedia` polyfill that allows to use `react-responsive` on our React Native projects.

We can just install the polyfill.
```console
$ yarn add react-native-match-media-polyfill
```

Then in your `index.js`:
```js
import 'react-native-match-media-polyfill';
import { AppRegistry } from 'react-native';
// ... your other codes
```
{: file='index.js' }


## Sample Code
```jsx
import React from 'react';
import 'react-native-match-media-polyfill';
import { SafeAreaView, Text } from 'react-native';
import { useMediaQuery } from 'react-responsive';

export default function App() {
  const isMobile = useMediaQuery({ query: '(max-width: 600px)' });
  const isPortrait = useMediaQuery({ query: '(orientation: portrait)' });

  return (
    <SafeAreaView>      
      <Text>{isMobile ? 'mobile' : 'not mobile'}</Text>
      <Text>Your are in {isPortrait ? 'portrait' : 'landscape'} orientation</Text>
    </SafeAreaView>
  );
}
```

To run the sample code you also need to install `react-responsive`.
```console
$ yarn add react-responsive
```

The above code prints `mobile` when the screen's device width is less than or equal to `600px`, also prints whether you are on `portrait` or `landscape` mode.

This allows us to use the power of media queries to our React Native app.
