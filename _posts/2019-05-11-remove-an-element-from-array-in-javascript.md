---
categories: ['General Programming']
tags: ['JavaScript']
---
The following snippets allows you to remove an element from array in JavaScript.

## Mutating

### Using pop
```js
let myArray = [1, 2, 3, 4, 5]
myArray.pop()
console.log(myArray) // [1, 2, 3, 4]
```

Removes an element from the end of the array and mutates itself.

### Using shift
```js
let myArray = [1, 2, 3, 4, 5]
myArray.shift()
console.log(myArray) // [2, 3, 4, 5]
```

Removes an element from the start of the array and mutates itself.

### Using splice
```js
let myArray = [1, 2, 3, 4, 5]
myArray.splice(0, 2)
console.log(myArray) // [3, 4, 5]
```

Removes an element based on the indices of the elements. In this example, we removed `2 elements` starting from index `0`.

```js
let myArray = [1, 2, 3, 4, 5]
myArray.splice(2, 2)
console.log(myArray) // [1, 2, 5]
```

Removes an element based on the indices of the elements. In this example, we removed `2 elements` starting from index `2`.

## Non-mutating
### Using filter
```js
let myArray = [1, 2, 3, 4, 5]
myArray = myArray.filter((element) => element !== 3)
console.log(myArray) // [1, 2, 4, 5]
```

Removes an element based on the condition and returns a new array. In this example, we only returned array elements **not equal to 3**.

### Using length
```js
let myArray = [1, 2, 3, 4, 5]
myArray.length = 2
console.log(myArray) // [1, 2]
```

Removes an element based on the indices of the elements. In this example, we removed elements starting with index `2` and so on.

Setting the array length to `0` means the array will become empty.

### Using delete operator
```js
let myArray = [1, 2, 3, 4, 5]
delete myArray[2]
console.log(myArray) // [1, 2, undefined, 4, 5]
```

Removes only the value of an element based on the index of the element and returns the same length of array as the original. In this example, we removed the value of index `2`.

Do you have any more ways to remove an element from array in JavaScript? Share it on the comments below.
