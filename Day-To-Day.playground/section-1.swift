// Playground - noun: a place where people can play

import Cocoa
import Foundation

var dict = ["hello": "cheese"]

dict["hello"] = "world"
dict["please"] = "cheesecake"
countElements(dict)

let arr = ["Hello","cheese"]
arr[1] = "world"
arr
countElements(arr)

var aPoint = CGPointMake(9.0, 10.0)

var str = "Hello World!"
countElements(str)


func happy(anArray: Array<String>) {
    anArray.append("s")
}