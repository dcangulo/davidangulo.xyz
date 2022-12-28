---
title: 'React Native Outside Press'
order: 12
---
## Project Information
[airbnb/react-outside-click-handler](https://github.com/airbnb/react-outside-click-handler) but for React Native.

* **Homepage:** [https://www.npmjs.com/package/react-native-outside-press](https://www.npmjs.com/package/react-native-outside-press)
* **Source Code:** [https://github.com/dcangulo/react-native-outside-press](https://github.com/dcangulo/react-native-outside-press)
* **Tech Stack:** React, React Native, TypeScript

## Usage
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

Then wrap every component you want with `OutsidePressHandler` to detect outside press.

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
