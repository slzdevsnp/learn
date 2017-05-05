//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Sviatoslav Zimine on 5/1/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController, UITextFieldDelegate,
                             UINavigationControllerDelegate,
                             UIImagePickerControllerDelegate {
    

    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var serialField: UITextField!
    
    @IBOutlet var valueField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    


    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
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
        
        //add the image associated with item key 
        imageView.image = imageStore.image(forKey: item.itemKey)
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
    
    //MARK:  - pictures
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker  = UIImagePickerController()
        
        //chk if device has a camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        //place imagePicker on the screen when tapped on icon
        present(imagePicker, animated:true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        //get picked image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
     
        //store image in imageStore
        imageStore.setImage(image, forKey: item.itemKey)
        
        //put image on the screen in the image view
        imageView.image = image
        
        //tack imagePicker offscreen
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func removeImage(_ sender: UIBarButtonItem) {

        imageStore.deleteImage(forKey: item.itemKey)
        
        imageView.image = nil
        
    }
    
}
