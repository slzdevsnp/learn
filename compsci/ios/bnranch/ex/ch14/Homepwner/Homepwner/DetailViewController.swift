//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Sviatoslav Zimine on 5/1/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController, UITextFieldDelegate {
    

    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var serialField: UITextField!
    
    @IBOutlet var valueField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //clear first responder
        view.endEditing(true)
        
        
        //save item state
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        }else{
            item.valueInDollars = 0
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
}
