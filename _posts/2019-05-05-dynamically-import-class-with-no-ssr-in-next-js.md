---
categories: ['Website Development']
tags: ['FullCalendar', 'JavaScript', 'Next.js', 'React']
title: 'Dynamically import class with no SSR in Next.js'
---
In this tutorial, I will show you how to dynamically import class with no SSR in Next.js.

Probably you already have seen this [Next.js documentation](https://nextjs.org/docs/#with-no-ssr) regarding dynamically importing component with no SSR. But the problem with this is that it can only be used on React components, but what if we need to dynamically import a non-React component class?

This guide will show you how. I will use FullCalendar plugin called [FullCalendar interaction](https://www.npmjs.com/package/@fullcalendar/interaction) as this has a class that I need to dynamically import to make it work. (READ: [How to use FullCalendar in Next.js](/posts/how-to-use-fullcalendar-in-next-js/))

## Step 1: Initialize a Next.js project
Initialize a Next.js project by running the following commands in the terminal.

```console
$ mkdir import-class-nextjs
$ cd import-class-nextjs
$ touch package.json
```

Paste the following inside `package.json` that we have created.

```json
{
  "scripts": {
    "dev": "next",
    "build": "next build",
    "start": "next start"
  }
}
```

Install the necessary Next.js packages by running the following command in the terminal.

```console
$ yarn add  next react react-dom
```

Let’s create an index or landing page for our project using the following commands.

```console
$ mkdir pages
$ touch pages/index.js
```

Page the following inside `pages/index.js` that we have created.

```jsx
export default function Home() {
  return <div>Welcome to Next.js!</div>
}
```

This is just a simple component for our landing page which just returns a single div component.

## Step 2: Dynamically import class with no SSR
Install the package that you need. In this example, we are going to use FullCalendar interaction plugin.

```console
$ yarn add @fullcalendar/core @fullcalendar/interaction
```

If you tried to import this the usual way `import interactionPlugin from '@fullcalendar/interaction'` you will get an error `Element is not defined` as `Element` is non-existent on the server side rendering.

The solution is to make sure that the `window` is already defined when you import the package.

Since Next.js is a React framework we can take advantage of using `componentDidMount` if you are using class components or `useEffect` when using functional components.

The importing of package can be written as follows.

```jsx
import { useEffect } from 'react'

export default function Home() {
  useEffect(() => {
    dynamicallyImportPackage()
  }, [])

  let dynamicallyImportPackage = async () => {
    const FullCalendarInteraction = await import('@fullcalendar/interaction')
    // you can now use the package in here
  }

  return <div>Welcome to Next.js!</div>
}
```

That’s it, we have now successfully imported a non-React component class with no SSR in Next.js.
