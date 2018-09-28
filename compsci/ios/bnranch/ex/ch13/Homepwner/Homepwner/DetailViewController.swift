//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Sviatoslav Zimine on 5/1/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    

    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var serialField: UITextField!
    
    @IBOutlet var valueField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item!
    
    let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter : DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text =  numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text =  dateFormatter.string(from: item.dateCreated)
    }
    
}
