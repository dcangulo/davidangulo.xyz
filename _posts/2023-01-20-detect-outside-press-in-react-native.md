---
categories: ['Mobile App Development']
tags: ['React Native', 'Expo', 'Android', 'iOS', 'react-native-web', 'react-native-windows', 'react-native-macos']
title: 'Detect outside press in React Native'
---
`onPress` and `onClick` events are one of the most common events used on mobile, web, and desktop apps development. But what if we want the opposite? We want to detect the press event outside of a component. Luckily this is a common pattern that there are modules that handle this.

[airbnb/react-outside-click-handler](https://github.com/airbnb/react-outside-click-handler) have been great but it does not work with React Native only on React web.

This is why I developed [react-native-outside-press](https://github.com/dcangulo/react-native-outside-press), which works on most React Native platforms such as [Vanilla](https://github.com/facebook/react-native), [Expo](https://github.com/expo/expo), [react-native-web](https://github.com/necolas/react-native-web), [react-native-windows](https://github.com/microsoft/react-native-windows), and [react-native-macos](https://github.com/microsoft/react-native-macos).

## Step 1: Create a blank React Native project.
```console
$ npx react-native init sample
$ cd sample
```

Skip this step when you already have a functioning app.

## Step 2: Install the module.
```console
$ yarn add react-native-outside-press
```

## Step 3: Using the module.
Wrap your app with `EventProvider`.
{% raw %}
```jsx
import { EventProvider } from 'react-native-outside-press';

export default function App() {
  return (
    <EventProvider style={{ flex: 1 }}>
      <RestOfYourApp />
    </EventProvider>
  );
}
```
{% endraw %}

The `EventProvider` component accepts all [View's props](https://reactnative.dev/docs/view#props).

Then wrap every component you want to detect outside press with `OutsidePressHandler`.
{% raw %}
```jsx
import { View } from 'react-native';
import OutsidePressHandler from 'react-native-outside-press';

export default function MyComponent() {
  return (
    <OutsidePressHandler
      onOutsidePress={() => {
        console.log('Pressed outside the box!');
      }}
    >
      <View style={{ height: 200, width: 200, backgroundColor: 'black' }} />
    </OutsidePressHandler>
  );
}
```
{% endraw %}

The `OutsidePressHandler` components accepts all [View's props](https://reactnative.dev/docs/view#props) with 2 additional props named `onOutsidePress` and `disabled`.

Now every time we press outside of `MyComponent`, `Pressed outside the box!` will be logged.
