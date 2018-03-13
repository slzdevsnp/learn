//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sviatoslav Zimine on 5/8/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class PhotosViewController : UIViewController {
    
    @IBOutlet var imageView: UIImageView!

    
    var store: PhotoStore!
    
 
    override func viewDidLoad(){
        super.viewDidLoad()
        
        /*
        store.fetchPhotosJson() //this older methods returns formatted requests json
        */
        
        store.fetchInterestingPhotos {
           (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                    print("successfully found \(photos.count) interesting photos.")
                    if let firstPhoto = photos.first {
                        print("updating image for \(firstPhoto.remoteURL)")
                        self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                    print("Error fetching interesting photos: \(error)")
            }
        }
        
        
        
    }
    
    func updateImageView(for photo: Photo){
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image) :
                    self.imageView.image = image
            case let .failure(error) :
                print("Error downloading image: \(error)")
            }
        }
    }
}
