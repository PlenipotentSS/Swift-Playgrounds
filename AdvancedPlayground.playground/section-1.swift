// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*

    MAKING THINGS ANONYMOUS!!!
    --> removing keys labels when declaring functions, etc
    --> Compacting!
*/

var dictionary: Dictionary = Dictionary<String, String>()

for (key, _) in dictionary {
    println(key)
}

var color = UIColor.greenColor()

extension UIColor {
    func rgba() ->() {  //how to return tuple?
        return (1,2,3,4)
    }
}

var red, blue: Int
(red, _, blue, _) = color.rgba()

//old
//class Thing {
//    init(location location: Thing?, name name: String, longDescription longDescription: String) {
//        
//    })
//}
//
//let thisThing = Thing(location: nil, name: "Pie", "Yummy Food")

// with anonymous names


class Thing {
    init(_ location: Thing?, _ name: String, _ longDescription: String) {
        
    }
}

let oneThing = Thing(nil, "Pie", "Yummy Food")
let thisThing = Thing(oneThing, "Filling", "What Makes the Pie Good!")

/*

    PULLABLE -> Protocols
*/
@objc protocol Pullable {   //why objc???
    func pull()
}

class BucketOfThings: Thing, Pullable {
    func pull() {
        
    }
    
    func performPull(object: Thing) {
        if let pullableObject = object as? Pullable {
            pullableObject.pull()
        } else {
            println("not pullable")
        }
    }
}

/*

    String INterpolation
*/


// Special Protocols:
/*
LogicValue                      if logicValue {
Printable                       "\(printable)"
Sequence                        for x in sequence()
IntegerLiteralConveritble       65536
FloatLiteralConvertible         1.0
StringLiteralConvertible        "abc"
ArrayLiteralConvertible         [a, b,c]
DictionaryLiteralConvertible    [a: x, b: y]
*/

protocol Printable {
    var description: String { get }
}

class AnObject: Printable {
    var name: String?
    
    var description: String {
        if let thisName = name {
            return thisName
        } else {
            return "No Name Found"
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
}

extension AnObject {
    var nameWithArticle: String {
        if let containsName = name {
            return "a " + containsName
        } else {
            return "nothing"
        }
    }
}

operator infix ~ {} //required to tell the compiler that ~ is an operator


func an(object: AnObject) -> String {
    return object.nameWithArticle
}

func ~ (decorate: (AnObject) -> String,
    object: AnObject) ->String {
        return decorate(object)
        
}

var object = AnObject("Steven")
println("You aren't sure how to pull a \(object.name).")
println("you aren't sure how to pull a \(object).")
println("you aren't sure how to pull \(object.nameWithArticle).") //not good

//binary operator:
println("you aren't sure how to pull \(an ~ object).")

enum Direction {
    case North, South, East, West
}

class Place: AnObject {
    init(_ name: String, _ longDescription: String) {
        
    }
    
    var exits: Dictionary<Direction, Place>
}

/*

    Connections
*/
extension Place {
    subscript(direction: Direction) -> Place? {
        get {
            return exits[direction]
        }
        set(destination: Place?) {
            exits[direction] = destination
        }
    }
}


let onePlace = Place("Chinese Bakery", "Cheap Pizza")
onePlace.exits[.North]
onePlace[.North]        //shortcut using connections


//WHEN SHOULD YOU DO THIS!?!?!?!?!
// Keep it natural... only use it when it is important to keep it simple, and make sure it is understable intuitively
// Work By Analogy... Don't try to do a subscript that would make it confusing!!
// New Idioms should pay for themselves... make sure it is worth while for someone to learn the change!!


/*

    SWIFT GENERICS!!!!
    Making functions and methods behave on a generic type!!
*/
func peek(value: String) {
    println("[peek] \(value)")
}
func peek(value: Int) {
    println("[peek] \(value)")
}
func peek(value: Float) {
    println("[peek] \(value)")
}

// why not use a generic type?
// even grabs more!
func peek<T>(value: T) -> T {
    println("[peek] \(value)")
}

extension String {
    var sansEmoji: String {
        get {
            //remove any emojis!
        }
    }
}

println( peek().capitalizedString().sansEmoji )


/*

    DYNAMIC POLYMORPHISM
    -> Type information is thrown away

    Generics Conserve type information!
    -> Great for type safety
    -> Great for Performance
*/


// work to swap out two objects, regardless of type
// but just has to be the same type!!
func swap<T>(inout x: T, inout y: T) {
    let tmp = x
    x = y
    y = tmp
}


func indexOfString(sought: String, inArray array: String[]) -> Int? {
    for i in 0..array.count {
        if array[i] == sought {
            return i
        }
    }
    return nil
}

//-> To Generics:
protocol Equatable {
    func == (lhs: Self, rhs: Self) -> Bool
}

// using equatable to ensure there is a way to compare two objects
func indexOf<T : Equatable>(sought: T, inArray array: T[]) -> Int? {
    for i in 0..array.count {
        if ( array[i] == sought) {
            return i
        }
    }
    return nil
}

//protocol can conform to almost anything
struct Temperature: Equatable {
    let value: Int = 0
}

//specific to operator requirements (must be at file scope level)
func == (lhs: Temperature, rhs: Temperature) -> Bool {
    return lhs.value == rhs.value
}

//don't need to write not equal! because:
func != <T : Equatable> (lhs: Temperature, rhs: Temperature) -> Bool {
    return !(lhs == rhs)
}


/*


    Computing the golden mean!
    (ratios of the consecutive fibonacci numbers)

*/
func fibonacci(n: Int) -> Double {
    return n < 2 ? Double(n) : fibonacci(n-1) + fibonacci(n-2)
}

let phi = fibonacci(45) / fibonacci(44) //takes 42 seconds
// doing this because there is repetitious calls (fibonacci(n-1) may be the same as fibonacci(n-2)
// now lets use memoization!

//lets improve it:

var fibonacciMemo = Dictionary<Int, Double>()

func fibonacciGood(n: Int) -> Double {
    if let result = fibonacciMemo[n] {
        return result
    }
    let result = n < 2 ? Double(n) : fibonacciGood(n-1) + fibonacciGood(n+2)
    fibonacciMemo[n] = result
    return result
}

let phi_2 = fibonacciGood(45) / fibonacciGood(44)   //takes .1 seconds



//How To Memoize any function!!!
func memoize<T : Hashable, U>( body: (T)->U ) -> (T)->U {
    var memo = Dictionary<T, U>()   //T must be hashable to become key!
    return {
        x in
        if let q = memo[x] { return q }
        let r = body(x)
        memo[x] = r
        return r
    }
}

//make any recursive call into a double initializion dance:
//take 1:
var factorial: (Int)->Int = { $0 }  //identity function!
factorial = memoize { x in x == 0 ? 1 : x * factorial(x-1) }


//take 2:
func memoize<T : Hashable, U>( body: ((T)->U, T)->U ) -> (T)->U {
    var memo = Dictionary<T, U>()   //T must be hashable to become key!
    var result: ((T)->U)!
    result = {
        x in
        if let q = memo[x] { return q }
        let r = body(result, x)
        memo[x] = r
        return r
    }
    return result
}

/// WOW: add factorial back into the body, called factorial (new closure)
let factorialTake2 = memoize { factorial, x in x == 0 ? 1: x * factorial(x - 1) }

/*
The Power:

Concision:
let fibonacci =

Closure Suntax!
let fibonacci = memoize { ... }

Generics!!
func memoize<T : Hashable, U>( body: ((T)->U, T)->U) -> (T)->U
*/


/*
    Generic Types:
    
    Seen them before:
    -> Arrays, Dictionaries
    -> Optionals (generic enums)

    Now: Struct:
*/

struct StringStack {
    mutating func push(x: String) {
        items += x
    }
    mutating func pop() -> String {
        return items.removeLast()
    }
    var items: String[]
}

//can be as easy as replacing the type arguments
struct Stack<T>{
    mutating func push(x: T) {
        items += x
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    var items: T[]
    
     init() {
        items
    }
}

var intStack = Stack<Int>()
intStack.push(42)
//var windowStack = Stack<NSWindow>()

//problem!!:

func peekStack(s: Stack<Int>) {
    for x in s { println(x) }   //issue because stack does not conform to sequence protocol
}

//under the hood, it calls s.generaor()
// followed by next()
// gotta make a Generator Protocol!

// Swift's base protocol:
protocol Generator {
    typealias Element
    mutating func next() -> Element?
}

// now we rewrite our stackgenerator as a struct:

struct StackGenerator<T>: Generator {
//    typealias Element = T // not necessary because T? is assumed on next line
    mutating func next() -> T? {
        if items.isEmpty { return nil }
        let ret = items[0]
        items = items[1..items.count]
        return ret
    }
    
    var items: Slice<T> //slices the array in O(1)
}

//now the sequence:
//swift's base protocol:
protocol Sequeuence {
    typealias GeneratorType : Generator
    func generate() -> GeneratorType
}

//now our addon extension:
extension Stack : Sequence {
    func generate() -> StackGenerator<T> {
        return StackGenerator( items[0..items.count])
    }
}

//need to now conform Stack<T> to conform to Sequence!


/*

    HIGH LEVEL ABASTRACTION
*/

