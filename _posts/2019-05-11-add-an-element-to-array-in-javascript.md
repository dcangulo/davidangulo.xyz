---
categories: ['General Programming']
tags: ['JavaScript']
title: 'Add an element to array in JavaScript'
---
The following snippets allow you to add an element to array in JavaScript.

## Mutating
### Using push
```js
let myArray = [1, 2, 3, 4]
myArray.push(5)
console.log(myArray) // [1, 2, 3, 4, 5]
```

Adds an element to the end of the array and mutates itself.

### Using unshift
```js
let myArray = [1, 2, 3, 4]
myArray.unshift(5)
console.log(myArray) // [5, 1, 2, 3, 4]
```

Adds an element to the start of the array and mutates itself.

## Using splice
```js
let myArray = [1, 2, 3, 4]
myArray.splice(myArray.length, 0, 5)
console.log(myArray) // [1, 2, 3, 4, 5]
```

Adds an element at a specific index. In this example, we used the length of the array as the index to add an element at the end of the array.

```js
let myArray = [1, 2, 3, 4]
myArray.splice(0, 0, 5)
console.log(myArray) // [5, 1, 2, 3, 4]
```

Adds an element at a specific index. In this example, we used `0` as the index to add an element at the start of the array.

```js
let myArray = [1, 2, 3, 4]
myArray.splice(1, 0, 5)
console.log(myArray) // [1, 5, 2, 3, 4]
```
Adds an element at a specific index. In this example, we used `1` as the index.

## Non-mutating
### Using concat
```js
let myArray = [1, 2, 3, 4]
myArray = myArray.concat(5)
console.log(myArray) // [1, 2, 3, 4, 5]
```

Adds an element to the end of the array and returns a new array.

### Using length
```js
let myArray = [1, 2, 3, 4]
myArray[myArray.length] = 5
console.log(myArray) // [1, 2, 3, 4, 5]
```

Adds an element to the end of the array using the next index of the last element.

## Using the spread operator
```js
let myArray = [1, 2, 3, 4]
myArray = [...myArray, 5]
console.log(myArray) // [1, 2, 3, 4, 5]
```

Adds an element to the end of the array and returns a new array.

```js
let myArray = [1, 2, 3, 4]
myArray = [5, ...myArray]
console.log(myArray) // [5, 1, 2, 3, 4]
```

Adds an element to the start of the array and returns a new array.

Do you have any more ways to add an element to array in JavaScript? Share it on the comments below.
