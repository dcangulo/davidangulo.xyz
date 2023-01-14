---
categories: ['Mobile App Development']
tags: ['React Native', 'Expo', 'Android', 'iOS', 'react-native-web', 'react-native-windows', 'react-native-macos', 'PKCE', 'OAuth']
title: 'Generate PKCE challenge in React Native'
---
[auth0's post titled "Which OAuth 2.0 Flow Should I Use?"](https://auth0.com/docs/get-started/authentication-and-authorization-flow/which-oauth-2-0-flow-should-i-use#is-the-client-a-native-mobile-app-) recommends that you use **Authorization Code Flow with Proof Key for Code Exchange (PKCE)** flow for you mobile apps.

## What is PKCE?
PKCE (pronounced 'pixy') offers more secure Authorization Code flow that is originally designed to protect mobile apps, but is now important for all OAuth clients.

From the official [OAuth 2.0 spec for PKCE](https://oauth.net/2/pkce/):

> PKCE ([RFC 7636](http://tools.ietf.org/html/rfc7636)) is an extension to the Authorization Code flow to prevent CSRF and authorization code injection attacks.

---

On web apps, generating PKCE challenge is straightforward with [Web Crypto API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Crypto_API), but in React Native this isn't available.

Lucky for us, there is already a module that handles this.

## Step 1: Create a blank React Native project.
```console
$ npx react-native init sample
$ cd sample
```

Skip this step when you already have a functioning app.

## Step 2: Install the react-native-pkce-challenge module.
```console
$ yarn add react-native-pkce-challenge
```

Run the next command if you're also supporting iOS.
```console
$ npx pod-install ios
```

Since this module contains native code, you need to rebuild your project.

## Step 3: Using the react-native-pkce-challenge module.
```jsx
import React from 'react';
import { SafeAreaView, Text } from 'react-native';
import pkceChallenge from 'react-native-pkce-challenge';

const challenge = pkceChallenge();

export default function App() {
  return (
    <SafeAreaView>
      <Text>Challenge: {challenge.codeChallenge}</Text>
      <Text>Verifier: {challenge.codeVerifier}</Text>
    </SafeAreaView>
  );
}
```
{: file='App.tsx' }

The constant `challenge` holds an object like the following:
```js
{
  codeChallenge: 'XsRstqNrXT76Iop3uMoyyCQmaGthJbKKJwXBSoQXaRk',
  codeVerifier: 'OZOHUwLddiPyTFJulnUYnU9jsf7oyULflbFpwj40bE9S77iaeisGvzvaVvvPE7oO-xaV4skxwKDFBBV7JofVNxCgUSauqUDVcVjggE4-M6zthVUmeUrSAHatmIBm_P0_'
}
```

You can now use this pair when requesting to your OAuth provider.

