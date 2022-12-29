---
categories: ['General Programming']
tags: ['JSON', 'JavaScript']
title: 'Pretty print JSON in JavaScript'
---
There are times that I use `JSON.stringify` to print my JSON just to see its contents. When the object is large it gets tedious to look at very fast, especially when dealing with array of objects.

Little did I know that `JSON.stringify` accepts 3 parameters not just 1.

But we'll only deal with the 3rd parameter in this post which is called `space`, it's a string or number that inserts white space so that we can read our JSON easily.

> See: [JSON.stringify docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify)

## The problem
Below is a sample JSON generated from [https://json-generator.com](https://json-generator.com).
```js
const sampleJSON = [
  {
    "_id": "63ad65e2841384fc83515df3",
    "index": 0,
    "guid": "13ff77fc-7853-4b51-9c35-11c5fd227ca3",
    "isActive": false,
    "balance": "$3,208.46",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "green",
    "name": "Cohen Mcdowell",
    "gender": "male",
    "company": "MAGMINA",
    "email": "cohenmcdowell@magmina.com",
    "phone": "+1 (985) 453-3227",
    "address": "895 Beverly Road, Thermal, Oregon, 586",
    "registered": "2021-09-21T02:07:46 -08:00",
    "latitude": -61.144217,
    "longitude": 8.630252
  },
  {
    "_id": "63ad65e2e00f2979623d1442",
    "index": 1,
    "guid": "811f0d48-d32e-4be4-8870-855ec6f58cbd",
    "isActive": true,
    "balance": "$2,771.56",
    "picture": "http://placehold.it/32x32",
    "age": 25,
    "eyeColor": "blue",
    "name": "Mullen Cannon",
    "gender": "male",
    "company": "ELEMANTRA",
    "email": "mullencannon@elemantra.com",
    "phone": "+1 (924) 569-2728",
    "address": "108 Elliott Walk, Allamuchy, Colorado, 4445",
    "registered": "2018-12-18T02:13:09 -08:00",
    "latitude": -10.734962,
    "longitude": -47.403147
  }
];
```
{: file='sample.js' }

Now let's put that in a sample JavaScript file, in this example we will name it `sample.js`.

On the same file we can add:
```js
console.log(JSON.stringify(sampleJSON));
```
{: file='sample.js' }

Notice that when we run:
```console
$ node sample.js
```

```js
[{"_id":"63ad65e2841384fc83515df3","index":0,"guid":"13ff77fc-7853-4b51-9c35-11c5fd227ca3","isActive":false,"balance":"$3,208.46","picture":"http://placehold.it/32x32","age":40,"eyeColor":"green","name":"Cohen Mcdowell","gender":"male","company":"MAGMINA","email":"cohenmcdowell@magmina.com","phone":"+1 (985) 453-3227","address":"895 Beverly Road, Thermal, Oregon, 586","registered":"2021-09-21T02:07:46 -08:00","latitude":-61.144217,"longitude":8.630252},{"_id":"63ad65e2e00f2979623d1442","index":1,"guid":"811f0d48-d32e-4be4-8870-855ec6f58cbd","isActive":true,"balance":"$2,771.56","picture":"http://placehold.it/32x32","age":25,"eyeColor":"blue","name":"Mullen Cannon","gender":"male","company":"ELEMANTRA","email":"mullencannon@elemantra.com","phone":"+1 (924) 569-2728","address":"108 Elliott Walk, Allamuchy, Colorado, 4445","registered":"2018-12-18T02:13:09 -08:00","latitude":-10.734962,"longitude":-47.403147}]
```

The output is hard to read.

## The solution

But if we add a 3rd parameter.
```js
console.log(JSON.stringify(sampleJSON, null, 2));
```

And run it again.
```console
$ node sample.js
```

```js
[
  {
    "_id": "63ad65e2841384fc83515df3",
    "index": 0,
    "guid": "13ff77fc-7853-4b51-9c35-11c5fd227ca3",
    "isActive": false,
    "balance": "$3,208.46",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "green",
    "name": "Cohen Mcdowell",
    "gender": "male",
    "company": "MAGMINA",
    "email": "cohenmcdowell@magmina.com",
    "phone": "+1 (985) 453-3227",
    "address": "895 Beverly Road, Thermal, Oregon, 586",
    "registered": "2021-09-21T02:07:46 -08:00",
    "latitude": -61.144217,
    "longitude": 8.630252
  },
  {
    "_id": "63ad65e2e00f2979623d1442",
    "index": 1,
    "guid": "811f0d48-d32e-4be4-8870-855ec6f58cbd",
    "isActive": true,
    "balance": "$2,771.56",
    "picture": "http://placehold.it/32x32",
    "age": 25,
    "eyeColor": "blue",
    "name": "Mullen Cannon",
    "gender": "male",
    "company": "ELEMANTRA",
    "email": "mullencannon@elemantra.com",
    "phone": "+1 (924) 569-2728",
    "address": "108 Elliott Walk, Allamuchy, Colorado, 4445",
    "registered": "2018-12-18T02:13:09 -08:00",
    "latitude": -10.734962,
    "longitude": -47.403147
  }
]
```

That's so much better than the previous one.

The value `2` that we passed is the number of space for indention. You can select up to `10`, if you put a number more than that `10` will still be used.

Also note that this is supported natively, you don't need some 3rd party npm package to use this.
