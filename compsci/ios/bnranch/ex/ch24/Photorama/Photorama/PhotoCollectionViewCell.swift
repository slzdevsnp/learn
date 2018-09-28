//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Sviatoslav Zimine on 5/9/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell :  UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner:  UIActivityIndicatorView!
    
    var photoDescription: String?
    
    func update (with image: UIImage?){
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        }else{
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    //2 funcs below reset the cell back to the spinnig state
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
    
    
    //MARK: - accessibility
    override var isAccessibilityElement: Bool {
        get {
            return true
        }
        set {
            super.isAccessibilityElement = newValue
        }
    }
    override var accessibilityLabel: String? {
        get {
            return photoDescription
        }
        set {
            //ignore attempts to set
        }
    }
    
    override var accessibilityTraits: UIAccessibilityTraits {
        get{
            return super.accessibilityTraits | UIAccessibilityTraitImage
        }
        set{
            //ignore attemps to set
        }
    }
}
