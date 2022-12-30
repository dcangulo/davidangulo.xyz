---
categories: ['Website Development']
tags: ['JavaScript', 'redirect']
title: 'Whitelist domain in JavaScript'
---
I recently migrated this blog from WordPress to Jekyll and I currently host this blog for free at [DigitalOcean App Platform](https://www.digitalocean.com/products/app-platform).

If you're DigitalOcean App Platform you can access your website via something like `yourappname-xxxxx.ondigitalocean.app`. Where `yourappname` is your app name, while `xxxxx` is some random 5 character alphanumeric.

When you decide to use a custom domain, you can only add a `CNAME` record to your `DNS` record. This means your website can be accessed on 2 different domains, your custom domain and the domain provided by DigitalOcean.

This also happens for apps deployed in Heroku where it can be accessed on both custom domain and on `yourappname.herokuapp.com` domain.

However, DigitalOcean **currently** don't support `301` redirect for static sites at the time of writing this post. I can probably do it on an app level, but since this is a static site, it currently can't be done unless DigitalOcean itself support it.

## My workaround

```js
const allowedHosts = ['www.davidangulo.xyz', 'localhost'];

if (!allowedHosts.includes(window.location.hostname)) {
  window.location.href = window.location.href.replaceAll(window.location.host, 'www.davidangulo.xyz');
}
```

I just created an array of `allowedHosts` and if the `window.location.hostname` is not one of them then I would just redirect them to `www.davidangulo.xyz` version of the site.

I also included `localhost` so that it still works as expected on development mode.

Since this is a Jekyll site, I put the script in `_layouts/default.html` inside the `head` tag.

---

If you want to only whitelist a specific port of `localhost`, e.g. only `localhost:4000`, then you can make the following changes.

```diff 
- const allowedHosts = ['www.davidangulo.xyz', 'localhost'];
+ const allowedHosts = ['www.davidangulo.xyz', 'localhost:4000'];

- if (!allowedHosts.includes(window.location.hostname)) {
+ if (!allowedHosts.includes(window.location.host)) {
    window.location.href = window.location.href.replaceAll(window.location.host, 'www.davidangulo.xyz');
  }
```

This will only allow access to `www.davidangulo.xyz` and `localhost:4000`, not other ports. `window.location.host` includes the port number while `window.location.hostname` does not.

## Conclusion
If your website can be accessed on 2 different domains with the same content be sure to use `<link rel="canonical" href="" />` with `href` is linked to the primary domain in this case `www.davidangulo.xyz`.

While this works, take note that this is just a workaround when all else fails.

It is still the best to redirect using your web server such as NGINX, or in your app level if you have Rails, Laravel, Express, etc.
