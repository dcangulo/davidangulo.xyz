---
title: 'React Native PKCE Challenge'
order: 10
---
## Project Information
Proof Key for Code Exchange (PKCE) challenge generator for React Native.

* **Homepage:** [https://www.npmjs.com/package/react-native-pkce-challenge](https://www.npmjs.com/package/react-native-pkce-challenge)
* **Source Code:** [https://github.com/dcangulo/react-native-pkce-challenge](https://github.com/dcangulo/react-native-pkce-challenge)
* **Tech Stack:** React Native, TypeScript, C++, Java, Objective-C++

## Usage
```js
import pkceChallenge from 'react-native-pkce-challenge';

const challenge = pkceChallenge();
```

The constant `challenge` will hold an object like the following:

```js
{
  codeChallenge: 'XsRstqNrXT76Iop3uMoyyCQmaGthJbKKJwXBSoQXaRk',
  codeVerifier: 'OZOHUwLddiPyTFJulnUYnU9jsf7oyULflbFpwj40bE9S77iaeisGvzvaVvvPE7oO-xaV4skxwKDFBBV7JofVNxCgUSauqUDVcVjggE4-M6zthVUmeUrSAHatmIBm_P0_'
}
```
