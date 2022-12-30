---
categories: ['Website Development']
tags: ['JavaScript', 'redirect']
title: 'Redirect 404 pages in JavaScript'
---
I recently migrated this blog from WordPress to Jekyll but due to the differences in permalinks, some posts now appear as 404. My old permalink for post is `/:slug` while it's now `/posts/:slug`.

I currently host this blog for free at [DigitalOcean App Platform](https://www.digitalocean.com/products/app-platform). They don't **currently** support `301` redirect for static sites at the time of writing this post.

Due to this, I have to resort redirecting the `404` pages myself using JavaScript.

## How did I do it?

I simply created the following script:
```js
const currentUrl = new URL(window.location.href);
const isRedirected = !!currentUrl.searchParams.get('r');

if (!isRedirected) {
  fetch(window.location.href, {
    method: 'HEAD',
  }).then((response) => {
    if (response.status !== 404) return;

    const redirectUrl = new URL([window.location.origin, '/posts', window.location.pathname].join(''));
    redirectUrl.searchParams.set('r', 1);
    window.location.href = redirectUrl.href;
  });
}
```

Let's break it down and know where to put it.

```js
fetch(window.location.href, {
  method: 'HEAD',
})
```

Since we only have to know whether the current page is `404` or not, I created an HTTP request to the current page with method `HEAD` to only get the headers.

```js
.then((response) => {
  if (response.status !== 404) return;

  const redirectUrl = new URL([window.location.origin, '/posts', window.location.pathname].join(''));
  redirectUrl.searchParams.set('r', 1);
  window.location.href = redirectUrl.href;
});
```

If the current page is not `404` then we'll just do nothing. 

Since I migrated from `/:slug` to `/posts/:slug`, I simply created the `redirectUrl` by adding `/posts` in the middle.

You can set `redirectUrl` to any URL you want to redirect to.

I also added `r=1` as query string so that if `/posts/:slug` is still `404` it won't infinitely redirect. It's simply an identifier that we have gotten to this page from a redirect and don't redirect further.

```js
const currentUrl = new URL(window.location.href);
const isRedirected = !!currentUrl.searchParams.get('r');

if (!isRedirected) {
  // fetch request
}
```

Now I simply check if `r` has a value, if it does, then it means that we have already been redirected to this page, then instructs to not redirect further.

## Where did I put it?

Since this is a Jekyll site, I put it in `_layouts/default.html` inside the `head` tag.

```html
<!DOCTYPE html>
<html>
  <head>
    <!-- Your other stylesheets and scripts -->
    <script type="text/javascript">
      const currentUrl = new URL(window.location.href);
      const isRedirected = !!currentUrl.searchParams.get('r');

      if (!isRedirected) {
        fetch(window.location.href, {
          method: 'HEAD',
        }).then((response) => {
          if (response.status !== 404) return;

          const redirectUrl = new URL([window.location.origin, '/posts', window.location.pathname].join(''));
          redirectUrl.searchParams.set('r', 1);
          window.location.href = redirectUrl.href;
        });
      }
    </script>
  </head>
  <body>
    <!-- Your content -->
  </body>
</html>
```
{: file='_layouts/default.html' }

Just put it in your global layout, this depends on what framework you're using.

### Jekyll
If you're using Jekyll it's probably in `_layouts/default.html`.

### Rails
If you're using Rails it's probably in `app/views/layouts/application.html.erb`. 
> You probably don't need this if you're on Rails though.

### Next.js
If you're using Next.js it's probably in `pages/_document.js`.
> You probably don't need this if you're on Next.js though.

### Create React App (CRA)
If you're using CRA it's probably in `public/index.html`.

### Expo
If you're using Expo it's probably in `App.js`.

## Conclusion
While this works, take note that this is just a workaround when all else fails.

This kind of redirect can hurt your SEO as crawlers don't follow this kind of redirect as this doesn't return a `3XX` status code.

It is still the best to redirect using your web server such as NGINX, or in your app level if you have Rails, Laravel, Express, etc.
