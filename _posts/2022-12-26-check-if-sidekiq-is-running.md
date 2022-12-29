---
categories: ['Website Development']
tags: ['Sidekiq']
title: 'Check if Sidekiq is running'
---
There is a simple command to check whether sidekiq is running or not.

```console
$ ps aux | grep '[s]idekiq'
```

If it's running you should get something like the following as a response:
```text
davidangulo      55267   0.0  1.3 35183332 223084 s006  S+    3:26PM   0:05.05 sidekiq 5.2.8 myapp [0 of 3 busy]
```

That's it. Thank you for reading.
