---
categories: ['Website Development']
tags: ['FullCalendar', 'JavaScript', 'Next.js', 'React']
title: 'How to use FullCalendar in Next.js'
---
> This tutorial has been updated for **React v18**, **Next.js v13**, and **FullCalendar v6**. If you are looking for the older version of this tutorial, you can access it [here](https://github.com/dcangulo/davidangulo.xyz/blob/8feed40d8963ae36c8a215eb602af4abb131407c/_posts/2019-04-27-how-to-use-fullcalendar-in-next-js.md).
{: .prompt-info }

In this tutorial, we would be learning on how to use FullCalendar in Next.js.

You might have been able to come here because you have encountered an error `Element is not defined` when you are trying to use FullCalendar in Next.js project.

## Cause of the error

Next.js renders the page on the server side. Since it was on the server side, `window` is not available as it is only available on the client side. If the `window` is not available, then the `element` is also not available.

Now that we understand the problem, let’s proceed with the solution.

## Step 1: Initialize a Next.js project
Let’s start with initializing our Next.js project by running the following commands in the terminal.

```console
$ yarn create next-app nextjs-fullcalendar --js --no-eslint
$ cd nextjs-fullcalendar
```

## Step 2: Install FullCalendar
Now, let’s install FullCalendar to our project. Run the following command in the terminal.

```console
$ yarn add @fullcalendar/core @fullcalendar/react @fullcalendar/daygrid @fullcalendar/timegrid
```

## Step 3: Create your own FullCalendar component
Let’s start by creating a directory for our components. Run the following commands in the terminal.

```console
$ mkdir components
$ touch components/fullcalendar.js
```

In the file `components/fullcalendar.js`, paste the following.
```jsx
import Calendar from '@fullcalendar/react';
import dayGrid from '@fullcalendar/daygrid';
import timeGrid from '@fullcalendar/timegrid';

export default function FullCalendar(props) {
  return <Calendar plugins={[dayGrid, timeGrid]} {...props} />;
}
```
{: file='components/fullcalendar.js' }

That seems easy. Yes, it's easy now with **React v18**, **Next.js v13**, and **FullCalendar v6**. In the past, we have to jump on different hoops setting this up.

If you're interested on how to set this up on the previous versions you may read it [here](https://github.com/dcangulo/davidangulo.xyz/blob/8feed40d8963ae36c8a215eb602af4abb131407c/_posts/2019-04-27-how-to-use-fullcalendar-in-next-js.md).

## Step 4: Use our own FullCalendar component
In the file `pages/index.js`, paste the following.
```jsx
import FullCalendar from '../components/fullcalendar';

export default function Home() {
  return (
    <div>
      <FullCalendar initialView='dayGridMonth' />
      <FullCalendar initialView='timeGridWeek' />
    </div>
  );
}
```
{: file='pages/index.js' }

Now if you run `yarn dev` in the terminal and navigate to [http://localhost:3000](http://localhost:3000) in your browser, you should be able to see the two (2) calendars, one in month view and one in week view rendered properly without any errors.

That’s it, we have learned on how to use FullCalendar in Next.js project.
