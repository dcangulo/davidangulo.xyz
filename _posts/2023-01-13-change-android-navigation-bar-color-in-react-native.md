---
categories: ['Mobile App Development']
tags: ['React Native', 'Android']
title: 'Change Android navigation bar color in React Native'
---
Having [bottom tab navigator](https://reactnavigation.org/docs/bottom-tab-navigator) is one of the commonly used navigators in React Native. Usually we customize the UI of this navigator to match our needs.

The problem arises when the Android's navigation bar does not match the look and feel of the bottom tab navigator. On iOS, this is a simple task to do, just set the background color of your `SafeAreaView` and you're good to go.

Lucky for us, there is already a module that handles this for us.

## Step 1: Create a blank React Native project.
```console
$ npx react-native init sample
$ cd sample
```

Skip this step when you already have a functioning app.

## Step 2: Install the module.
```console
$ yarn add react-native-navigation-bar-color
```

Since this module contains native code, you have to rebuild your project.

## Step 3: Using the module.

```jsx
import React from 'react';
import { SafeAreaView, Button } from 'react-native';
import changeNavigationBarColor from 'react-native-navigation-bar-color';

export default function App() {
  return (
    <SafeAreaView>
      <Button title='Set to Red' onPress={() => changeNavigationBarColor('red')} />
    </SafeAreaView>
  );
}
```
{: file='App.tsx' }

Here we have a screen with a button that toggles the navigation bar color to red when pressed.

The modules also has other functions such as hiding and showing navigation bar, but that seems out of scope for this post. If you're interested you may head to the [module's documentation](https://github.com/thebylito/react-native-navigation-bar-color#readme).
