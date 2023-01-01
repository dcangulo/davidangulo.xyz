---
categories: ['Website Development']
tags: ['Trix', 'JavaScript', 'Next.js', 'React', 'WYSIWYG']
title: 'Use Trix WYSIWYG editor in Next.js'
---
Trix editor have been my go to WYSIWYG editor on both React and non-React projects, sometimes I am required to use it on a Next.js project, encountered some hiccups but manage to make it work with some configurations.

If you use Trix directly on Next.js without any custom configuration, you might encounter the error `ReferenceError: navigator is not defined`.

## Cause of the error
Next.js renders the page on the server. But since `navigator` is only available on the client-side, and we attempt to use it on the server, it gives the `ReferenceError: navigator is not defined` error.

Now I'll show you on how I managed to make it work.

## Step 1: Initialize a Next.js project
Let’s start with initializing our Next.js project by running the following commands in the terminal.

```console
$ yarn create next-app nextjs-trix --js --no-eslint
$ cd nextjs-trix
```

If you already have a running app, you may skip this step.

## Step 2: Install Trix
Now, let’s install Trix to our project. Run the following command in the terminal.

```console
$ yarn add trix react-trix-rte
```

## Step 3: Create your own no SSR Trix component
Let’s start by creating a directory for our components. Run the following commands in the terminal.

```console
$ mkdir components
$ touch components/trix.js
```

In the file `components/trix.js`, paste the following.
```jsx
import React from 'react';
import dynamic from 'next/dynamic';

const loadingComponent = () => <div>Loading ...</div>;
const WysiwygComponent = dynamic(() => {
  import('trix');
  return import('react-trix-rte').then((m) => m.ReactTrixRTEInput);
}, {
  ssr: false,
  loading: loadingComponent,
});

export default function Trix(props) {
  if (props.loading) return loadingComponent();

  return <WysiwygComponent {...props} />;
}

Trix.defaultProps = {
  loading: false,
};
```
{: file='components/trix.js' }

The problem that we have is that Next.js renders our page on the server. In the docs, there is a way to [dynamically import packages with no ssr](https://nextjs.org/docs/advanced-features/dynamic-import#with-no-ssr).

We simply imported Trix using Next.js' `dynamic` function that allows us to dynamically import modules and disable SSR by adding `ssr: false` flag.

I also added a `loading` prop because in my experience when we set the component's `defaultValue` prop from an `async` source, sometimes the `defaultValue` does not show due to a race condition where the editor initializes first before the `async` source completes.

## Step 4: Use our own Trix component
In the file `pages/index.js`, paste the following.
```jsx
import React, { useState } from 'react';
import Trix from '../components/trix';

export default function Home() {
  const [value, setValue] = useState('');

  return (
    <Trix 
      defaultValue={value} 
      onChange={(e, newValue) => setValue(newValue)} 
    />
  );
}
```
{: file='pages/index.js' }

Now if you run `yarn dev` in the terminal and navigate to [http://localhost:3000](http://localhost:3000) in your browser, you should be able to see a WYSIWYG without any errors.

That’s it, we have learned on how to use Trix WYSIWYG editor in a Next.js project.
