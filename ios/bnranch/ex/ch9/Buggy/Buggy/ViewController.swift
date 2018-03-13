//
//  ViewController.swift
//  Buggy
//
//  Created by Sviatoslav Zimine on 4/7/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func buttonTapped(_ sender: UIButton){
    //@IBAction func switchToggled(_ sender: UISwitch){
        //print("called buttonTapped(_:)")
        print("Method:\(#function) in file:\(#file) line:\(#line)  column:\(#column) called")
        print("sender: \(sender)")
        
        intentionalyBadMethod()
    }
    
    
    func intentionalyBadMethod(){
        let array  = NSMutableArray()
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        //go over and array boundary // does not produce an exception
        for _ in 0...11 {
            array.remove(at: 0)
            
        }
        
        var mn: Int?
        mn = 10
        //mn = nil
       
        let mnn = mn! + 10  //produce a crash
        print("mnn \(mnn)")
        
    }

}

