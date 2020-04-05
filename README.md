# Function Tools #

Some basic tools for functional programming


## `blackhole` ##

Simply functions which take a value and do nothing with it. Useful for testing and mocks.
For example:
```swift
stuff.forEach(blackhole)
```


## `call` ##

A utility function which simply calls the given function. This is useful for compressing higher-order functions.
For example:
```swift
let someFunctions: [BlindCallback] = [
    { print("Hello") },
    { print("World!") },
]

someFunctions.forEach(call)
```


## `curry` ##

Converts a non-currying function into a currying function.
For example:
```swift
let add = curry(+)
[1, 2, 3, 4].map(add(4)) // [5, 6, 7, 8]
```


## Function Types ##

Some typealiases for common functions:



### Callbacks ###

* `BlindCallback` and `ThrowingBlindCallback`
    * A function that you'd pass to another one as a callback, which doesn't need to know anything nor report anything 


### Transformer family of functions ###

* `Transformer` and `ThrowingTransformer`
    * A function which can transform one thing into another, like the kind you pass to a `map` function

* `Filter` and `ThrowingFilter`
    * A function which can filter a sequence of elements, like the kind you pass to a `filter` function


### Reducer family of functions ###

* `Reducer` and `ThrowingReducer`
    * A function which can reduce a sequence of elements into one value, like the kind you pass to a `reduce` function

* `AllocationReducer` and `ThrowingAllocationReducer`
    * A function which can reduce a sequence of elements into one value by allocating new reductions, like the kind you  pass to a `reduce` function. Often slower than `Reducer`.


### Combinator family ###

* `Combinator` and `ThrowingCombinator`
    * A function which can combine two values into one

* `CurriedCombinator`
    * A function which can combine two values into one, over the course of multiple separate function calls.
