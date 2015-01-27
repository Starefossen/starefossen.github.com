---
layout: post
title: Securing SSL in HAProxy
date: 2015-01-26
tag: [opsec, ssl, haproxy]
twitter: starefossen
published: true
---

<p class="lead">Finally, the next ticket on Jira said "Disable RC4 from cipher
suite". It was time to bring back the A on the SSL Server Test result page which
had recently been downgraded to a B.</p>

![Qualys SSL Server Test before HAProxy config update](/uploads/2015/01/26/summary_b.png)

For those who do not know, [Qualys SSL Server
Test](https://www.ssllabs.com/ssltest/) is THE online SSL analyzer. To say it
mildly, these guys knows SSL, with all it's quarks and all! All you have to do
is to type in a domain name and Qualys will start testing all kinds of aspects
of the TLS connection.

So, what happened? Last time we checked we had an A- on your report card.
Suddenly we had a B! To understand what happened we have to go back to 2011
where [BEAST attack](http://vnhacker.blogspot.com/2011/09/beast.html) was
disclosed. SSL Labs, and others,
[recrommended](https://community.qualys.com/blogs/securitylabs/2011/10/17/mitigating-the-beast-attack-on-tls)
prioritizing the RC4 cipher:

> The only reliable way to defend against BEAST is to priorities RC4 cipher
> suites.

Since this was the only option, we too configured our servers to priorities the
RC4 cipher. Fast forward two years; RC4 now accounts for 50% of all TLS traffic,
and then i happens. Researches find [new
weakneses](http://www.isg.rhul.ac.uk/tls/) in the already troubled RC4 cipher.

The attack on the RC4 cipher is still [highly
improbable](https://community.qualys.com/blogs/securitylabs/2013/03/19/rc4-in-tls-is-broken-now-what),
there aren't any good workarounds either, that SSL Labs decides not to take any
actions in their grading algorithm, until now recently.

![Qualys SSL Server Test RC4 warning](/uploads/2015/01/26/rc4_warning.png)

### Configuring HAProxy

When this change was noticed within your team we started researching how we
could improve our score on SSL Labs. We quickly found the
[cipherli.st](https://cipherli.st) website, however their suggested cipher suite
were too strict for us (sadly, we have to support IE > 7).

We then went to Mozilla which has an [excellent
article](https://wiki.mozilla.org/Security/Server_Side_TLS) on recommended TLS
configurations with different levels of security in mind. We choose the
Intermediate compatibility (default) configuration:

> For services that don't need compatibility with legacy clients (mostly WinXP),
> but still need to support a wide range of clients, this configuration is
> recommended. It is is compatible with Firefox 1, Chrome 1, IE 7, Opera 5 and
> Safari 1.

This configuration disables SSLv3 and recommends key sizes of 2048 bits.
With that in mind we ended up with the following HAProxy configuration:

```
global
  tune.ssl.default-dh-param 2048

  ssl-default-bind-options no-sslv3 no-tls-tickets
  ssl-default-bind-ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA

  ssl-default-server-options no-sslv3 no-tls-tickets
  ssl-default-server-ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA
```

### Profit

I am proud to announce that the Norwegian Trekking Association's website again
gets an A on Qualys SSL Server Test result page. All our trekking data is still
belonging to us!

![Qualys SSL Server Test after HAProxy config update](/uploads/2015/01/26/summary_a.png)

SSL can be intimidating and there is a lot of terminology to get familiar with.
The certificate authority system is also a hairy mess to get used to. Thankfully
we have tools to test and the knowledge to configure. Going forward we will add
the SSL Server Test as one of our regular procedures in order to make sure we
always follow best practices for securing TLS.

