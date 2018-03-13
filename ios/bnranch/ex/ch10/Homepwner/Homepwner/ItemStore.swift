//
//  ItemStore.swift
//  Homepwner
//
//  Created by Sviatoslav Zimine on 4/10/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allitems = [Item]()
    
    //create 5 random items in default initializer
    init(){
        let idepth = 6
        for _ in 0..<idepth {
            createItem()
        }

    }
    
    @discardableResult  func createItem() -> Item {
        let newItem = Item(random: true)
        allitems.append(newItem)
        return newItem
    }
    
    
    
}
