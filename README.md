# Function Tools #

Some basic tools for functional programming


## `blackhole` ##

Simply functions which take a value and do nothing with it. Useful for testing and mocks.
For example:
```swift
stuff.forEach(blackhole)
```


## `null` ##

Like `blackhole`, this simply functions which take a value and do nothing with it. Unlike `blackhole`, this will always be optimized away in production code. Useful for giving to functions which demand a callback, when you don't have anything to do after it calls back.
For example:
```swift
myObject.someAsyncFunction(onComplete: null)
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


## `echo` ##

Simply returns what it's given. This is useful for reusing the input of higher-order functions.
For example:
```swift
let withoutNils = arrayOfOptionals.compactMap(echo)
```

It's also useful for flattening collections of generators.
For example:
```swift
let values = generators.map(echo)
```


## `!` ##

Converts any function which returns a `Bool` into one which returns the opposite value.
For example:
```swift
public extension Array {
    func exclude(by filter: @escaping Transformer<Element, Bool>) -> some LazySequenceProtocol {
        self.lazy.filter(!mapper)
    }
}
```


## Function Types ##

Some typealiases for common functions:



### Callbacks ###

* `BlindCallback` and `ThrowingBlindCallback`
    * A function that you'd pass to another one as a callback, which doesn't need to know anything nor report anything 
* `Callback` and `ThrowingCallback`
    * A function that you'd pass to another one as a callback, which needs to know the result of the other one 


### Transformer family of functions ###

* `Transformer` and `ThrowingTransformer`
    * A function which can transform one thing into another, like the kind you pass to a `map` function

* `Filter` and `ThrowingFilter`
    * A function which can filter a sequence of elements, like the kind you pass to a `filter` function


### Generator family of functions ###

* `Generator` and `ThrowingGenerator`
    * A function which can generate one thing without any input, like in an `@autoclosure`


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
