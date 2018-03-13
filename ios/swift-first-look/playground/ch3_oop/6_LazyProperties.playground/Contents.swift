//: Playground - noun: a place where people can play

import UIKit


class DatabaseConnection{
    
    init(){
        print("new database is up and running")
    }
    func execution(statement:String) -> Void{
        print("EXECUTE: \(statement)")
    }
}

class DataStore{
    //with lazy keyword  the init() in Database connection is not executed automatically
    lazy var connection = DatabaseConnection()
}


let ds = DataStore()
//before accsessing a DatabaseConnection method  the init() is called
ds.connection.execution(statement: "SELECT * from USERS")

