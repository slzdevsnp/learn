//
//  InventoryItem.swift
//  inventoryapp
//
//  Created by Brett Romero on 12/27/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class InventoryItem: NSObject {
    var name:String = ""
    var units:Int = 0
    var manufacturerName:String = ""
    var dateAdded:Date
    
    init(name:String, units:Int, manufacturerName:String, dateAdded:String){
        self.name = name
        self.units = units
        self.manufacturerName = manufacturerName
        let dateFormatter = DateFormatter()
        
        if(dateAdded.contains("/")){
            dateFormatter.dateFormat = "MM/dd/yyyy"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        }
        self.dateAdded = dateFormatter.date(from: dateAdded)!
    }
}
