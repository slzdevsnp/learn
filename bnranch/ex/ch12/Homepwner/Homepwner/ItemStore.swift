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
        let idepth = 5
        for _ in 0..<idepth {
            createItem()
        }
    }
    
    @discardableResult  func createItem() -> Item {
        let newItem = Item(random: true)
        allitems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item){
        if let index = allitems.index(of: item){
            allitems.remove(at: index)
        }
    }
    
    func moveItem(from  fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return //nothing to do
        }
        let movedItem = allitems[fromIndex]
        //remove it 
        allitems.remove(at: fromIndex)
        //insert moved item to a new index
        allitems.insert(movedItem, at: toIndex)
    }
    
}
