---
categories: ['DevOps']
tags: ['CDN', 'Cloudflare']
title: 'How To Setup Cloudfare CDN To your Website'
---
This tutorial will guide you to setup Cloudflare CDN to your website. This aims to share the knowledge about CDN and why you should use it.

## What is CDN and why should I use it?
CDN (Content Delivery Network) is a system of distributed servers across the globe.

Websites use CDN to minimize the distance of the visitors to your website’s server. An example if your website host is in the United States while your visitor is in the Philippines, it will take a longer time to deliver content from the United States to the Philippines rather than China to the Philippines.

The goal of CDN is to distribute your content to different servers and data centers around the globe. So if your website is accessed from the Philippines then the content will be coming from the nearest server rather than getting the same content from a farther server.

## Step 1: Create a Cloudflare account.
Go to the [official Cloudflare website](https://www.cloudflare.com/) and click **Sign Up** on the menu bar. Fill up the required fields in the form and click **Create Account**.

![cloudflare-homepage](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/cloudflare-homepage.jpg)

*Picture 1.1. Cloudflare Website*

![registration-form](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/registration-form.jpg)

*Picture 1.2. Cloudflare Registration Form*

## Step 2: Add your domain name to Cloudflare.
After you have successfully registered to Cloudflare, you will be asked to enter the domain name of your site. For this example, I will use `lccmdormitory.xyz` as the domain name. After entering your domain name click the **Add Site** button.

![add-site](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/add-site.jpg)

*Picture 2.1. Adding your website to Cloudflare.*

## Step 3: Select a Plan
You have to select a plan of your choice, for this example, I will pick the** FREE Plan with $0/month**.

![select-plan](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/select-plan.jpg)

*Picture 3.1. Select a Plan for your website.*

## Step 4: Set up DNS records to be protected by Cloudflare.
Toggle all gray icons to allow Cloudflare to protect them.

![dns-records](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/dns-records.jpg)

*Picture 4.1. Before (Some DNS records are not protected by Cloudflare)*

![dns-records-after](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/dns-records-after.jpg)

*Picture 4.2. After (DNS Records are now protected by Cloudflare)*

## Step 5: Point your nameservers to Cloudflare nameservers.
Each hosting server has their own nameservers. For this example, I host my site in [freehosting.com](https://www.freehosting.com/) so my nameservers point to their server and we need to change this to point it to the Cloudflare servers.

Not sure on how to change your name server? Here are the tutorials from some domain name registrars. If your domain name registrar is not on the list you may consider contacting your provider or open a support ticket to help you out.

* [GoDaddy](https://ph.godaddy.com/help/set-custom-nameservers-for-domains-registered-with-godaddy-12317)
* [Hostinger](https://www.hostinger.com/tutorials/dns/pointing-domain-to-new-hosting)
* [Namecheap](https://www.namecheap.com/support/knowledgebase/article.aspx/767/10/how-can-i-change-the-nameservers-for-my-domain)
* [SiteGround](https://www.siteground.com/kb/how_to_change_my_ns_record/)

![nameservers](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/nameservers.jpg)

*Picture 5.1. Pointing the nameservers to Cloudflare*

My domain name is registered on Hostinger so I should follow the steps they have given.

![hosting-nameservers](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/hosting-nameservers.jpg)

*Picture 5.2. Finding my nameservers.*

I copied the nameservers from **Picture 5.1** to replace my current nameservers. After that, click the **Update** button.

![connect-nameservers](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/connect-nameservers.jpg)

*Picture 5.3. Replacing my current nameservers to Cloudflare nameservers.*

Go back to the Cloudflare website as seen in **Picture 5.1** and click **Continue**.

## Note:
It may take up to **72 hours** for your DNS to propagate worldwide. Propagation happens whenever you change your nameservers, during the propagation it may work on some machines. Once it has been completed you should receive an email from Cloudflare. You may also check the status on Cloudflare website. This process is safe and your website will not face any downtime while being processed.

Just wait, wait and wait. If the process has been completed and successful, the overview of your website should look like this.

![status](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/status.jpg)

*Picture 6.1. A website successfully configured on Cloudflare.*

Here is a test from [webpagetest.org](https://www.webpagetest.org/) on our example site `lccmdormitory.xyz` where it presents the before and after configuring Cloudflare to our website.

![result-before](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/result-before.jpg)

*Picture 6.2. Before (No Cloudflare CDN)*

![result-after](/assets/images/posts/how-to-setup-cloudflare-cdn-to-your-website/result-after.jpg)

*Picture 6.3. After (Successfully configured Cloudflare CDN)*

That’s it, you have now configured your site to the Cloudflare CDN. You should experience faster loading times and improved security.
