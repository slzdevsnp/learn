//
//  ViewController.swift
//  pchatapp
//
//  Created by Sviatoslav Zimine on 3/15/18.
//  Copyright © 2018 Sviatoslav Zimine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func LoginButton_click(_ sender: Any) {
        //let temail = "test1@gmail.com"
        //let tpasswd = "openopen"
        FirebaseManager.Login(email: email.text!,  password: password.text!,
                              completion: { (success:Bool) in
                                if (success){
                                    self.performSegue(withIdentifier: "showProfile", sender: sender)
                                }
                            })
        
    }
    
    @IBAction func CreateAccountButton_click(_ sender: Any) {
    }
    
}

