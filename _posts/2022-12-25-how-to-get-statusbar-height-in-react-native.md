---
categories: ['Mobile App Development']
tags: ['React Native']
---
There are different ways of getting the `statusBarHeight` in React Native and I will show some of the ways.

## Expo
If you're using Expo you can use `Constants.statusBarHeight`.

```js
import Constants from 'expo-constants';
const statusBarHeight = Constants.statusBarHeight;
```

## Vanilla React Native (with React Navigation)
If you're using Vanilla React Native with React Navigation you can use the following:

```js
import { useSafeAreaInsets } from 'react-native-safe-area-context';

export default function ComponentName() {
  const insets = useSafeAreaInsets();
  const statusBarHeight = insets.top;
}
```

See: [https://reactnavigation.org/docs/handling-safe-area/#use-the-hook-for-more-control](https://reactnavigation.org/docs/handling-safe-area/#use-the-hook-for-more-control)

## Sample Code:
```jsx
import * as React from 'react';
import { Text, View, StatusBar, StyleSheet } from 'react-native';
import Constants from 'expo-constants';
import { useSafeAreaInsets, SafeAreaProvider } from 'react-native-safe-area-context';

export default function App() {
  return (
    <SafeAreaProvider>
      <ChildScreen />
    </SafeAreaProvider>
  );
}

function ChildScreen() {
  const insets = useSafeAreaInsets();
  
  return (
    <View style={styles.container}>
      <Text>
        {insets.top}
      </Text>
      <Text>
        {Constants.statusBarHeight}
      </Text>
      <Text>
        {StatusBar.currentHeight ?? 'N/A'}
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    justifyContent: 'center',
  },
});
```

### Output:

|                                    | Samsung Galaxy S10 5G | iPhone 8 Plus | iPhone 11 Pro Max | Web |
|------------------------------------|-----------------------|---------------|-------------------|-----|
| `insets.top`                       | 39.71428680419922     | 20            | 44                | 0   |
| `Constants.statusBarHeight`        | 39                    | 20            | 44                | 0   |
| `StatusBar.currentHeight ?? 'N/A'` | 39.42856979370117     | N/A           | N/A               | N/A |

Live Demo: [https://snack.expo.dev/@dcangulo/statusbarheight](https://snack.expo.dev/@dcangulo/statusbarheight)
