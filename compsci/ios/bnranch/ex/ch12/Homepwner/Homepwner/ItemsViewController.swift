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
    
 
    
    @IBAction func addNewItem(_ sender: UIButton){

        //create new item
        let newItem = itemStore.createItem()
        
        //find ound index of the newItem in allItems 
        if let index = itemStore.allitems.index(of: newItem){  //safe code
            let indexPath = IndexPath(row:index, section:0)
        
            //insert this new row in the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton){
    
        if isEditing{
            //change text of button to inform a user of state
            sender.setTitle("Edit", for: .normal)
            //turn off editing mode
            setEditing(false, animated: true)
        }else{
            //change text to inform user of the state
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height 
        let insets = UIEdgeInsets(top: statusBarHeight, left:0,bottom:0,right:0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        return itemStore.allitems.count
    }
 
    
    
    //to show a row in a table
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)-> UITableViewCell{
    
        // a cell with default appearance
        

        //get a cell from a reusable pool
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                for: indexPath) as! ItemCell
        
        let item = itemStore.allitems[indexPath.row]
        //configure the cell with the item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        if (item.valueInDollars < 50 ) {
         cell.valueLabel.textColor = UIColor.green
        } else {
        cell.valueLabel.textColor = UIColor.red
        }
         //cell.valueLabel.textColor = UIColor.green
        return cell
    }
    
    // to remove rows from table
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath){
        //if the table view is asking to commit a delete command..
        if editingStyle == .delete{
            let item = itemStore.allitems[indexPath.row]
            
            //add user alert
            let  atitle = "Delete \(item.name)?"
            let  amessage = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: atitle, message: amessage, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive,
                                             handler:{(action) -> Void in
                                                self.itemStore.removeItem(item) // remove item in focus
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                                            })
            ac.addAction(deleteAction)
            //present the alert controller //takes the whole screen
            present(ac, animated:true, completion: nil)
        }
    }
    
    //to reorder rows in table
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath){
        //update the model
        itemStore.moveItem(from: sourceIndexPath.row,
                           to: destinationIndexPath.row)
    }
    
    
    
    
    
}
