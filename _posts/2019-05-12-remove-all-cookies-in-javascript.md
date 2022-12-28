---
categories: ['Website Development']
tags: ['JavaScript', 'Cookies']
title: 'Remove all cookies in JavaScript'
---
The following snippet allows you to remove all cookies in JavaScript (client-side).

```js
document.cookie.split(';').forEach((c) => {document.cookie = c.replace(/^ +/, '').replace(/=.*/, `=;expires=${(new Date()).toUTCString()};path=/`)});
```

You can use it by pasting it directly on the browser console.
