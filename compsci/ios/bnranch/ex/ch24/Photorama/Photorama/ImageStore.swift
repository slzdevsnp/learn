//
//  ImageStore.swift
//  Homepwner
//
//  Created by Sviatoslav Zimine on 5/4/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<NSString,UIImage>()
    
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
        //save image to fs
        let url = imageURL(forKey: key)
        if let data = UIImagePNGRepresentation(image){
            //write to the url of the image
            let _ = try? data.write(to: url, options: [.atomic])
            print("Saved an image for itemkey: \(key) to a filepath: \(url.path)")
        }
    }
    
    func image(forKey key: String) -> UIImage?{
    
        if let existingImage = cache.object(forKey : key as NSString) {
            return existingImage  //we have an image in cache, return it with no other hassle
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        //put fetched from FS image to the cache as it is not there
        cache.setObject(imageFromDisk, forKey: key as NSString )
        
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
        let url  = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let fileDeleteError { //custom error variable
            print("Error removing the image from disk \(fileDeleteError)")
        }
    }

    //MARK: -- archiving
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    

}
