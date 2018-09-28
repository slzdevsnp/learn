//
//  chatTableViewCell.swift
//  pchatapp
//
//  Created by Brett Romero on 11/14/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class chatTableViewCell: UITableViewCell {

    @IBOutlet var messageText: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
