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
}
