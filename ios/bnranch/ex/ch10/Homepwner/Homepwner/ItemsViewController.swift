//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Sviatoslav Zimine on 4/7/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    
    var itemStore: ItemStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height 
        let insets = UIEdgeInsets(top: statusBarHeight, left:0,bottom:0,right:0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        return itemStore.allitems.count +  1
    }
 
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)-> UITableViewCell{
    
        // a cell with default appearance
        
        /*
        let cell = UITableViewCell(style: UITableViewCellStyle.value1,
                                   reuseIdentifier: "UITableViewCell")
        */
        //get a cell from a reusable pool
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        if (indexPath.row == itemStore.allitems.count){
            let item = Item(name:"No more items!",
                           serialNumber: nil,
                           valueInDollars: 0)
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = ""
        }else{
            let item = itemStore.allitems[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        }
        
        return cell
    }
    
}
