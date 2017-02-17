// Playground - noun: a place where people can play

import UIKit

class DatabaseConnection {
    init() {
        println("New Database is up and running!")
    }
    
    func execute(statement: String) {
        println("EXECUTE: \(statement)")
    }
}

class DataStore {
    // Declaring this as 'lazy' means an instance won't be created
    // until it's first referenced
    lazy var connection = DatabaseConnection()
}

let ds = DataStore()

// The DataStore's connection is finally instantiated when we make this call
ds.connection.execute("SELECT * FROM users")
