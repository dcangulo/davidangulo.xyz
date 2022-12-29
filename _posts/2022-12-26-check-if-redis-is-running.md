---
categories: ['Website Development']
tags: ['Redis']
title: 'Check if Redis is running'
---
## Redis CLI
There is a simple command to check whether redis is running or not.

Just simply run the following command on your command line.

```console
$ redis-cli ping
```

If it is running it should respond with the following:

```text
PONG
```

## Homebrew

You can also check with another command if you're using Homebrew.

```console
$ brew services
```

It should return all services that are running through Homebrew, this includes redis.

```text
Name   Status  User        File
redis  started davidangulo ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```

If it's running correctly it should have a status of `started`.

## Listening on the default redis port

Redis on a default setup usually listens on port `6379`. 

We can listen to that port using the following command.

```console
$ lsof -i:6379
```

We should get an output if it's running and also check the name if it matches `redis` in any way, as it might be another process running on port `6379`.

```text
COMMAND    PID        USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
redis-ser 2593 davidangulo    6u  IPv4 0xef09d3625c99e681      0t0  TCP localhost:6379 (LISTEN)
redis-ser 2593 davidangulo    7u  IPv6 0xef09d36726e52c19      0t0  TCP localhost:6379 (LISTEN)
```
That's it. Thank you for reading.
