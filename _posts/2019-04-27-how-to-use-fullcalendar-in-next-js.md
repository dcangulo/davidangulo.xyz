---
categories: ['Website Development']
tags: ['FullCalendar', 'JavaScript', 'Next.js', 'React']
title: 'How to use FullCalendar in Next.js'
---
In this tutorial, we would be learning on how to use FullCalendar in Next.js.

You might have been able to come here because you have encountered an error `Element is not defined` when you are trying to use FullCalendar in Next.js project.

## Cause of the error

Next.js renders the page on the server side. Since it was on the server side, `window` is not available as it is only available on the client side. If the `window` is not available, then the `element` is also not available.

Now that we understand the problem, let’s proceed with the solution.

## Step 1: Initialize a Next.js project
Let’s start with initializing our Next.js project by running the following commands in the terminal.

```sh
mkdir nextjs-fullcalendar
cd nextjs-fullcalendar
touch package.json
```

In the `package.json` that we have created, paste the following.

```json
{
  "scripts": {
    "dev": "next",
    "build": "next build",
    "start": "next start"
  }
}
```

In the terminal, install Next.js by running the following command.

```sh
yarn add next react react-dom
```

Now, let’s create our landing page. Run the following commands in the terminal.

```sh
mkdir pages
touch pages/index.js
```

In the file `pages/index.js`, paste the following.

```jsx
export default function Home() {
  return <div>Welcome to Next.js!</div>
}
```

We just created a `Home` component that simply shows a short message on our landing page.

## Step 2: Setup Next.js CSS support
Since FullCalendar has custom CSS, we must setup our Next.js project to support CSS.

In the terminal run the following.

```sh
yarn add node-sass @zeit/next-sass @zeit/next-css
touch next.config.js
```

In the file `next.config.js`, paste the following.

```js
const withSass = require('@zeit/next-sass')
module.exports = withSass()
```

## Step 3: Install FullCalendar
Now, let’s install FullCalendar to our project. Run the following command in the terminal.

```sh
yarn add @fullcalendar/core @fullcalendar/react @fullcalendar/daygrid @fullcalendar/timegrid
```

Let’s create an SCSS file for the FullCalendar CSS by running the following commands in the terminal.

```sh
mkdir styles
touch styles/calendar.scss
```

In the file `styles/calendar.scss`, paste the following.

```scss
@import '~@fullcalendar/core/main.css';
@import '~@fullcalendar/daygrid/main.css';
@import '~@fullcalendar/timegrid/main.css';
```

## Step 4: Create your own no SSR FullCalendar component
Let’s start by creating a directory for our components. Run the following commands in the terminal.

```sh
mkdir components
touch components/fullcalendar.js
```

In the file `components/fullcalendar.js`, paste the following.

```jsx
import dynamic from 'next/dynamic'
import { useEffect, useState } from 'react'
import '../styles/calendar.scss'

let CalendarComponent

export default function FullCalendar(props) {
  const [calendarLoaded, setCalendarLoaded] = useState(false)

  useEffect(() => {
    CalendarComponent = dynamic({
      modules: () => ({
        calendar: import('@fullcalendar/react'),
        dayGridPlugin: import('@fullcalendar/daygrid'),
        timeGridPlugin: import('@fullcalendar/timegrid')
      }),
      render: (props, { calendar: Calendar, ...plugins }) => (
        <Calendar {...props} plugins={Object.values(plugins)} ref={props.myRef} />
      ),
      ssr: false
    })
    setCalendarLoaded(true)
  })

  let showCalendar = (props) => {
    if ( !calendarLoaded ) return <div>Loading ...</div>
    return (
      <CalendarComponent {...props} />
    )
  }

  return (
    <div>
      {showCalendar(props)}
    </div>
  )
}
```

The problem that we have is that Next.js renders our page in the server. In the docs, there is a way to [dynamically import packages with no ssr](https://nextjs.org/docs/#with-no-ssr).

We simply imported the `FullCalendar` component dynamically using Next.js’s dynamic function with an attribute `ssr: false` to make sure that it is not rendered on the server.

We also imported it in React’s `useEffect()` hook just to be sure that the `window` is already defined.

## Step 5: Use our own FullCalendar component
In the file `pages/index.js`, paste the following.

```jsx
import FullCalendar from '../components/fullcalendar'

export default function Home() {
  return (
    <div>
      <FullCalendar defaultView='dayGridMonth' />
      <FullCalendar defaultView='timeGridWeek' />
    </div>
  )
}
```

Now if you run `yarn dev` in the terminal and navigate to [http://localhost:3000](http://localhost:3000) in your browser, you should be able to see the two (2) calendars, one in month view and one in week view rendered properly without any errors.

## tl;dr
Install FullCalendar using the following command.

```sh
yarn add @fullcalendar/core @fullcalendar/react @fullcalendar/daygrid @fullcalendar/timegrid
```

Import the CSS in your styles.
```scss
@import '~@fullcalendar/core/main.css';
@import '~@fullcalendar/daygrid/main.css';
@import '~@fullcalendar/timegrid/main.css';
```

Dynamically import FullCalendar with no SSR and use the component in your project.

```jsx
import dynamic from 'next/dynamic'
import { useEffect, useState } from 'react'
import '../styles/calendar.scss'

let FullCalendar

export default function Home(props) {
  const [calendarLoaded, setCalendarLoaded] = useState(false)

  useEffect(() => {
    FullCalendar = dynamic({
      modules: () => ({
        calendar: import('@fullcalendar/react'),
        dayGridPlugin: import('@fullcalendar/daygrid'),
        timeGridPlugin: import('@fullcalendar/timegrid')
      }),
      render: (props, { calendar: Calendar, ...plugins }) => (
        <Calendar {...props} plugins={Object.values(plugins)} ref={props.myRef} />
      ),
      ssr: false
    })
    setCalendarLoaded(true)
  })

  let showCalendar = (props) => {
    if ( !calendarLoaded ) return <div>Loading ...</div>
    return (
      <FullCalendar {...props} />
    )
  }

  return (
    <div>
      {showCalendar(props)}
    </div>
  )
}
```

That’s it, we have learned on how to use FullCalendar in Next.js project.
