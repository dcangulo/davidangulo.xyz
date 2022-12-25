---
categories: ['General Programming']
tags: ['UUID']
---
## What is UUID?
A **universally unique identifier (UUID)** also known as **globally unique identifier (GUID)** is a 128-bit number used to identify computer systems information.

## UUID Versions
* V1 – Generated based on server’s mac address & current timestamp. (predictable)
* V3 – Generated based on the MD5 hash of namespace and name. (high probability of duplicate)
* V4 – Completely random. (unpredictable) (preferred version)
* V5 – Generated based on the SHA-1 hash of namespace and name. (high probability of duplicate)

## Chances
* A UUID never guarantees a unique record.
* There are **340,282,336,920,938,463,463,374,607,431,768,211,456** possible combinations.
* There is a ratio of **1:340282336920938463463374607431768211456** chance of getting a duplicate.
* There is **2.9387361 x 10^-39%** chance of getting a duplicate.
* There is a higher chance of getting hit by a bolt of lightning in your lifetime with **1:72000000** chance than generating duplicate UUID.

## Advantages
* It is presumably unique across every table, every database, every server.
* It permits straightforward merging of records from totally different databases.
* It allows easy distribution of databases across multiple servers.
* Most replication scenarios require UUID/GUID columns.
* IDs generated are hard to guess.
* It can be generated outside the database. A Ruby example is `SecureRandom.uuid`.

## Disadvantages
* It is a banging 4 times larger than the normal 4-byte index value.
* It is harder to debug. Imagine writing an SQL query like `WHERE user_id='12e986e5-7b58-4e0b-aafe-e78c081e8410'`.
* New records are inserted at random positions because it is not sequential.
* Drop in index performance.
* Extra configurations are needed.
* It is database dependent **if generated using a database function**.
* It generates ugly URLs **if you don’t use slugs**.

## Benchmark
A simple benchmark was created on a Ruby on Rails app using a `User` model with columns `fname` and `lname` using `Benchmark.ms`.

The record count of the model is thirteen (13) and shows the following result using the code `Benchmark.ms { User.all }`:

```txt
80.17600001767278ms (with UUID)
58.52800002321601ms (no UUID)
```

## When should you use UUIDS?
* When you don’t want the IDs to be predictable by the user. Eg. If there is `/user/100` there must be `user/99`, and so on.
* When you need to secure the record count of your database. Eg. A user registered on your site and its profile link is `/user/100` he can, therefore, think that he is the **100th user** to register on the site.
* When you don’t want to have collision on multiple instances of databases.
* When you need to use some of the advantages stated above.

## Conclusion
It is never necessary to use UUID. UUID’s ought to be used as a final resort once you have tried all alternative means of determining uniqueness on your architecture. It is recommended to avoid because of the performance limitations in indexing their values. UUID’s are also not particularly friendly to users.
