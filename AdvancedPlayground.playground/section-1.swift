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
*/


