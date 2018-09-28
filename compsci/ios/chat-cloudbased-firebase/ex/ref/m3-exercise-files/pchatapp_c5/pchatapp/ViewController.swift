//
//  ViewController.swift
//  pchatapp
//
//  Created by Brett Romero on 11/1/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButton_click(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "showProfile", sender: sender)
    }
    

}

