//: Playground - noun: a place where people can play

import Cocoa

var strv = "Hello, playground"


let hello_stripped = strv.substringWithRange( Range(start: strv.startIndex.advancedBy(0),
                                                    end: strv.startIndex.advancedBy(4)))


func stringEl(str:String,index:Int)->String{
    
    return str.substringWithRange( Range(start: str.startIndex.advancedBy(index),
        end: str.startIndex.advancedBy(index+1)))
}

stringEl(strv, index:0)
stringEl(strv, index:1)
stringEl(strv, index:2)










