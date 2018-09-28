//
//  ChatTableViewCell.swift
//  pchatapp
//
//  Created by Sviatoslav Zimine on 3/19/18.
//  Copyright © 2018 Sviatoslav Zimine. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

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
