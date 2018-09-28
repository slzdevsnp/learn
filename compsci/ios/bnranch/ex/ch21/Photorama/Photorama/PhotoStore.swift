//
//  PhotoStore.swift
//  Photorama
//
//  Created by Sviatoslav Zimine on 5/8/17.
//  Copyright © 2017 szimine. All rights reserved.
//


import UIKit

enum ImageResult{
    case success(UIImage)
    case failure(Error)
}

enum PhotoError : Error {
    case imageCreationError
}

enum PhotosResult{
    case success([Photo])
    case failure(Error)
}

class PhotoStore {
    
    let imageStore = ImageStore()
    
    private let session : URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    
    func fetchPhotosJson(){
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request ) { (data, response, error) -> Void in
            if let jsonData = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print("\(jsonObject)")
                } catch let error {
                    print("Error creating Json object: \(error)")
                }
            }else if let requestError = error {
                print("Error fetching interesting photos: \(requestError)")
            }else{
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }

    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void ){
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request ) { (data, response, error) -> Void in

            let result = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
            
        }
        task.resume()
    }
    
    
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else{
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    
    //download image data
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult)-> Void){
        
        let photoKey = photo.photoID
        //case image data is present in cache
        if let image = imageStore.image(forKey: photoKey){
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        
        let photoUrl = photo.remoteURL
        let request = URLRequest(url: photoUrl)
        
        let task = session.dataTask(with: request){
            (data,response,error) -> Void in
        
            let result = self.processImageRequest(data: data, error: error)
            
            // saved downloaded image data to the cache
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
 
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
            
                //cold not create image
                if data == nil {
                    return .failure(error!)
                }else{
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }
    
}
