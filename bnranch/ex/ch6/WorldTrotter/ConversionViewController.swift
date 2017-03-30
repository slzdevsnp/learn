//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Sviatoslav Zimine on 3/28/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit


extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    //szi simple implementation
    @IBAction func fahrenheitFieldEditingChanged_szi( _ textField: UITextField){
        
        let someDoubleFormat = ".2"
        if let text = textField.text,  !text.isEmpty, let fahval = Double(text) {
                let celctemp  = (fahval - 32) * 5 / 9
                celciusLabel.text = celctemp.format(f: someDoubleFormat)
     
        }else {
            celciusLabel.text = "???"
        }
    }
    
    //ranch impl
    var fahrenheitValue : Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celciusValue: Measurement<UnitTemperature>? {
        if let fv = fahrenheitValue {
            return fv.converted(to: .celsius)
        }else {
            return nil
        }
    }

    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    func updateCelsiusLabel(){
        if let celsv = celciusValue {
            //celciusLabel.text = "\(celsv.value)"
            celciusLabel.text =
                numberFormatter.string(from: NSNumber(value: celsv.value))
        }else{
            celciusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged( _ textField: UITextField){

        if let text = textField.text , let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }else {
            fahrenheitValue = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewCotroller loaded its view")
        
        updateCelsiusLabel()
    }
    
     var isDark = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ConvertViewController is about to load")
        if !isDark{
            self.view.backgroundColor = UIColor.darkGray
            isDark = true
        }else {
            self.view.backgroundColor = UIColor.white
            isDark = false
        }
    }
    
    //using a delegate to prevent putting more then 1 decimal point in input
    //implementing a method from UITextFieldDelegate protocol
    func textField(_ textField: UITextField
                ,shouldChangeCharactersIn range: NSRange
                , replacementString string: String) -> Bool{
        print("Current text: \(textField.text)")
        print("Replacement text: \(string)")
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        let letters = NSCharacterSet.letters
        let punct = [";", ":", "," , "!" ,"?" ,">" ,"<" ,"~"]
        var hasNonDigit = false
        for uni in string.unicodeScalars {
            if letters.contains(uni) || punct.contains(String(uni)) {
                hasNonDigit = true
                break
            }
        }
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil{
            return false
        }else if hasNonDigit{
            return false
        }else{
            return true
        }
    }
    
}



