//
//  Downloader.swift
//  UDownloader
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

// an enum to list downloader errors, implementing Error protocol
public enum DownloaderError: Error {
    case fileCopyError
}

//extend the error enum to provide error description
extension DownloaderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileCopyError:
            return NSLocalizedString("File copy error!", comment: "")
        }
    }
}


public struct Downloader {
    fileprivate static let session = URLSession(configuration: URLSessionConfiguration.default)
    fileprivate static let syncDownloadFileQueue = DispatchQueue(label: "Downloader.downloadToFile.syncQueue")

    //have a static download function with async handler

    /// Downloads large payloads to a local file
    ///
    /// - Parameters:
    ///   - url: URL of the remote resource
    ///   - localURL: location of the file to store the downloaded payloded
    ///   - completionHandler: invoked after the download completes
    public static func download(from url: URL, to localURL: URL,
                                completionHandler: @escaping (URLResponse?, Error?)->Void){
        syncDownloadFileQueue.sync{
            let request = URLRequest(url:url)
            //download task signature returning handlers for temporaryUrl, response and error
            let downloadTask = session.downloadTask(with: request) { tempURL, response, error in
                //treat the dwnload error
                guard error == nil else {
                    print("Failed to download from \(url), reason \(error?.localizedDescription)")
                    completionHandler(response, error)
                    return
                }
                //case to have an OK status code from response
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Download successfull from \(url), status \(statusCode)")
                }
         
                if let tempLocalUrl = tempURL {
                    do {
                        if let fileExists = try? localURL.checkResourceIsReachable(){
                            if fileExists {
                                print("Warning! file exist at path \(localURL)")
                                //if local temp file exists, try to delete it
                                do {
                                    try FileManager.default.removeItem(at: localURL)
                                } catch let deleteError {
                                    print("Failed to delete file \(localURL), reason \(deleteError)")
                                    completionHandler(response,deleteError)
                                }
                            }
                        }
                        try FileManager.default.copyItem(at: tempLocalUrl, to: localURL)
                        completionHandler(response,nil)
                    } catch let copyError{
                        print("Error copying file to \(localURL), reason \(copyError)")
                        completionHandler(response, copyError)
                    }
                }else {
                   completionHandler(response, DownloaderError.fileCopyError)
                }
            } // end of downloadTask initiation with a closure treating all error cases
            downloadTask.resume()
        }
    }
    
}
