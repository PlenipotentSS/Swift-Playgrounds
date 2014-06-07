// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let thisNumber = 5
let newStr = " \(str) I am  \(thisNumber) years old."

var shoppingList = ["catfish", "water", "people"]
shoppingList[1] = "bottle"
shoppingList[2]

print(shoppingList)

var i = 5; var numbers = 10
for j in 0..10 {
    
}

/*

Constants & Vars

*/
let 🐶🐮 = "dogcow"
let dogcow = 🐶🐮
println("There are weird images in my code, yet they can store a string: \(🐶🐮)")

//not predefined, so assign type
var anInt :Int
var aFloat :Float

//assigned literaly
var meaningOfLifeAssigned :Int = 42

//defined with literal value, so no need to assign type (it will be infered)
let meaningOfLife = 42

// assigning a literal floating point will infer a Double
let aDouble = 2.7462

//combining integer and floating point literals will create a double (types are only infered on assignment)
let pi = 3 + 0.14159

//different literals:

//integers
let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

let base10exp = 2e5

//doubles
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

// Integer conversion
// let negativeError: UInt8 = -1
// let tooBig: Int8 = Int8.max + 1

//Casting:
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3
let pointOneFourOneFive = 0.1415
let pi_2 = Double(three) + pointOneFourOneFive

let rounded_pi = Int(pi_2)

typealias AudioSample = UInt16
var maxAmplituedFound = AudioSample.min


let orangesAreOrange = true
let orangesAreRed = false

var orange: String
if orangesAreOrange {
    println("Yep!")
} else if orangesAreRed {
    orange = "Bad"
}

/*

TUPLES
multiple values in a single compound value
-> stores related files, NOT A DATA STRUCTURE!
*/
let httpStatus = (404, "Not Found")
let (code, message) = httpStatus
var response = "received: \(code) with message: \(message)"
var responseWithStatus = "received: \(httpStatus.1) with code: \(httpStatus.0)"

let http200Status = (statusCode: 200, description: "OK")
var completed = "\(http200Status.description)! You got code: \(http200Status.statusCode)"

/*

OPTIONALS (no more nil comparisons!)
there is a value, and it equals x
OR
there isn't a value at all
*/
let numberOfLegs = ["ant":6, "snake": 0, "people":2]
let possibleLegCount: Int? = numberOfLegs["aardvark"]

if possibleLegCount == nil {
    println("no aardvark found")
} else if possibleLegCount == 4 {
    println("it's a mammal!")
} else {
    println("Aardvar has \(possibleLegCount!) legs")
}

if let legCount = possibleLegCount {
    println("aardvark has \(legCount) legs")
}



/*

SWITCH (Control Flow)
*/

let thisInteger = 5
switch thisInteger {
case 1:
    println("not 1...")
case 2...10:
    println("somewhere between 2 and 5")
default:        //must have default!
    println("way off")
}

switch thisInteger {
case 0:
    println("it's 0!")
case 1, 3, 5, 7, 9:
    println("it's odd")
case 2, 4, 6, 8, 10:
    println("it's even")
default:
    println("it's above 10!")
}

var executeButton = "execute"
var firstNameTextField = "first name"
// using switch to determine which sender was performed on! (more used for IBACtions
func tappedSomething(sender: String) {
    switch sender {
    case executeButton:
        println("you tapped the execute button!")
    case firstNameTextField:
        println("you tapped a text field!")
    default:
        println("you tapped some other project")
    }
}



/*

Functions & Closures
*/

func computeSquare(value: Double) -> Double {
    return value*value
}

func sayHello(name: String = "World") {
    println("Hello " + name)
}
sayHello()
sayHello(name: "Me")
sayHello(name: "Cheese")
sayHello(name: "Cheese")

func sayExpandedHello(name: String = "Bob") -> (greeting: String, response: String) {
    return ("Hello " + name, "How are you?")
}
let conversationExpanded = sayExpandedHello(name: "Leah") //unnessary to give type
println( conversationExpanded.greeting )
println( conversationExpanded.response )

func thisMethod() {
    println("hi")
}

func repeat(count: Int, task: () -> ()) {
    for i in 0..count {
        task()
    }
}
repeat(2, thisMethod)
repeat(5, {
    println("repeat this 5 times")
})

/*

Classes
-> Don't have to write:
    -> Properties
    -> Extending Base Class
    -> Getters/Setters
*/

class Vehicle { //init is not necessary if simple
    //stored properties
    var numberOfWheels = 0 //property is an instance variable! same thing!
    let numberOfPeople = 1 //static property

    //computed properties
    var description: String {   //value can change
        return "\(numberOfWheels) wheels"
    }
    
    var detailedDescription: String {
        get {   //getter (not necessary if only returning a value
            return "A Basic vehicle with \(numberOfWheels) wheels"
        }
        set { //setter
            
        }
    }
}

let someVehicle = Vehicle()
someVehicle.description //is 0

class Bicycle: Vehicle {
    init() {
        super.init()
        numberOfWheels = 2
    } //doesn't return -> it just gives values to those that you want for the class
}

class Car: Vehicle {
    var speed = 0.0
    init() {
        super.init()
        numberOfWheels = 4
    }
    
    override var description: String {
        return super.description + ", \(speed) mph"
    }
}

class ParentsCar: Car {
    
    // Property Observers willSet and didSet
    override var speed: Double {
        willSet {
            if newValue > 65.0 {
                println("Whoa too fast!!!")
            }
        }
    }
}

class Counter {
    var count = 0
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func resetToCount(count: Int) {
        self.count = count //only need to use self if a naming conflict
    }
}

/*

STRUCTURES
*/

struct Point {
    var x,y: Double
}

struct Size {
    var width, height: Double
}

struct Rect {
    var origin: Point
    var size: Size
    
    var area: Double {
        return size.width * size.height
    }
    
    func isBiggerThanRect(other: Rect) -> Bool {
        return area > other.area
    }

}

let point = Point(x: 0.0, y: 0.0)
let size = Size(width: 100, height: 100)
let rect = Rect(origin: point, size: size)


//Diference of struct and class?
//
// 1. Structs cannot be subclassed
// 2. Structs are moved around, and not referenced

//class Window {
//    var frame: Rect
//    
//}

//Value Types:
//Mutating a STructure!!!
struct Point2 {
    var x, y: Double
    
    mutating func motToTheRightBy(dx: Double) {
        x += dx
    }
}

//enumerations:
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earthNumber = Planet.Mercury

enum CompassPoint {
    case North, South, East, West
}

var directionToHead = CompassPoint.West
directionToHead = .East //don't have to retype CompassPoint

let label = UILabel()
label.textAlignment = .Right //much easier


enum TrainStatus {
    case OnTime, Delayed(Int)
    
    init() { //set default
        self = OnTime
    }
    var description: String {
        switch self {
            case Ontime:
            return "on time"
        case Delayed( let minutes):
            return "late by \(minutes) minute(s)"
        default:
            return "unsure"
        }
    }
}

var trainStatus = TrainStatus() //status is inferred to be a TrainStatus
status.description
status = .Delayed(42)
status.description

//class Train {
//    enum Status {
//        case OnTime, Delayed(Int)
//        
//        init() { //set default
//            self = OnTime
//        }
//        var description: String {
//            switch self {
//            case Ontime:
//                return "on time"
//            case Delayed( let minutes):
//                return "late by \(minutes) minute(s)"
//            default:
//                return "unsure"
//        }
//    }
//    var thisStatus = Status()
//}
//
//
///* 
//
//Extensions
//*/
//
//extension Size {
//    mutation func increaseByFactor(factor: Int) {
//        width *= factor
//        height *= factor
//    }
//}
//
//extension Int {
//    func reptitions(task: () -> ()) {
//        for i in 0..self {
//            task()
//        }
//    }
//}
//
//500.reptitions({
//    println("Hello!")
//})
//

/* 

Generics
*/

struct Stack<T> {
    var elements = T[]()
    
    mutating func push(element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T {
        return elements.removeLast()
    }
}

var intStack = Stack<Int>()
intStack.push(50)
var lastIn = intStack.pop()

var stringStack = Stack<String>()
stringStack.push("Hello")
println(stringStack.pop())





