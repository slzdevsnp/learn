//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Sviatoslav Zimine on 5/8/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import Foundation


enum FlickrError : Error {
    case  invalidJSONData
}


enum Method: String {
    case interestingPhotos  = "flickr.interestingness.getList"
}




struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "a6d819499131071f158fd740860a5a88" //key preregistered for an application
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static var interestingPhotosURL: URL {
        return flickURL(method: .interestingPhotos,
                        parameters: ["extras": "url_h,date_taken"])
    }
    
    //a private implementation to construct url
    private static func flickURL(method: Method,
                                 parameters: [String:String]?) -> URL { //parameters is a 2d array of key:value params
        var components = URLComponents(string: baseURLString)!
 
        var queryItems = [URLQueryItem]() //prepare an array

        let baseParams = [
            "method" : method.rawValue, //access to .interestingPhotos associated string
            "format" : "json",
            "nojsoncallback": "1",
            "api_key" : apiKey
        ]
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value : value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key,value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }

    //to parse JSON for an individual photo 
    private static func photo(fromJSON json: [String:Any]) -> Photo? {
        guard
            let photoID         = json["id"] as? String,
            let title           = json["title"] as? String,
            let dateString      = json["datetaken"] as? String,
            let photoURLString  = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from: dateString) else{
                //don't have all info to create Photo object
                return nil
        }
        return Photo(title:title, photoID:photoID, remoteURL:url, dateTaken:dateTaken)
    }
    
    
    
    static func photos(fromJSON data: Data) -> PhotosResult {
        do {

            
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let photos = jsonDictionary["photos"] as? [String:Any],
                let photosArray = photos["photo"] as? [[String:Any]] else {
                
                //json structure does not match our expectations
                return .failure(FlickrError.invalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photo(fromJSON: photoJSON){
                    finalPhotos.append(photo)
                }
            }
            //check if photos data rcvd but was not parsed ok
            if finalPhotos.isEmpty && !photosArray.isEmpty {
                // we were unable to parse photos,  maybe json format for photos changed
                return .failure(FlickrError.invalidJSONData)
            }
            
            return .success(finalPhotos)
        }catch let error {
            return .failure(error)
        }
    }
    
    
    
    
}


