---
categories: ['DevOps']
tags: ['Cloudflare', 'SSL']
title: 'Force HTTPS website in Cloudflare'
---
If you installed an SSL on your website, you want it to be accessed on `https` rather than `http`. If you are also using Cloudflare I will show you how I forced my website to use `https`.

## Step 1: Login to your Cloudflare account.
Head over to the [official website of Cloudflare](https://www.cloudflare.com/) and click **Log In** in the top menu.

Enter your credentials and you should be redirected to your dashboard.

## Step 2: Select the website you want to force HTTPS.

On your dashboard, it should list all registered domains on your Cloudflare account.

![dashboard](/assets/images/posts/force-https-website-in-cloudflare/dashboard.png)
_Picture 2.1. Cloudflare Dashboard_

Select the website you want to force `https`. In this example we'll select `davidangulo.xyz`.

## Step 3: Set up a Page Rule.

On your left menu, click **Rules**, under it, click **Page Rules**.

![left-menu](/assets/images/posts/force-https-website-in-cloudflare/left-menu.png)
_Picture 3.1. Cloudflare Left Menu_

On that page, click **Create Page Rule** button.

![page-rule](/assets/images/posts/force-https-website-in-cloudflare/page-rule.png)
_Picture 3.2. Cloudflare Page Rule_

On the **URL (required)** field input your domain like this:

```text
http://*davidangulo.xyz/*
```

We use `*` to match all content of our website. The end `*` matches different pages on my website while the first `*` matches all subdomains of my website. We want to redirect all of those to use `https`.

Just change `davidangulo.xyz` with your own domain name.

Then for **Pick a Setting (required)** field, select **Always Use HTTPS**.

![rule](/assets/images/posts/force-https-website-in-cloudflare/rule.png)
_Picture 3.3. Cloudflare Page Rule_

To finalize, click **Save Page Rule**.

After a few minutes try accessing your website, and it should now be redirected to `https` if it's accessed on `http`.
