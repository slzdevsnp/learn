//
//  InventoryManager.swift
//  inventoryapp
//
//  Created by Brett Romero on 12/27/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class InventoryManager: NSObject {
    static var items:[InventoryItem] = []
    
    @discardableResult
    override init() {
        InventoryManager.items.append(InventoryItem(name: "Highlander", units: 50, manufacturerName: "Toyota", dateAdded: "11/20/2016"))
        InventoryManager.items.append(InventoryItem(name: "Altima", units: 40, manufacturerName: "Nissan", dateAdded:"11/21/2016"))
        InventoryManager.items.append(InventoryItem(name: "Focus", units: 70, manufacturerName: "Ford", dateAdded:"12/6/2016"))
        InventoryManager.items.append(InventoryItem(name: "Impreza", units: 10, manufacturerName: "Subaru", dateAdded:"12/5/2016"))
    }
    
    static func add(item:InventoryItem){
        InventoryManager.items.append(item)
    }
}
