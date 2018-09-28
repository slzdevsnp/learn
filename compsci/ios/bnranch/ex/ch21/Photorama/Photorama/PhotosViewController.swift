//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sviatoslav Zimine on 5/8/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class PhotosViewController : UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    var photoDataSource = PhotoDataSource()
 
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        /*
        store.fetchPhotosJson() //this older methods returns formatted requests json
        */
   
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchInterestingPhotos {
           (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("successfully found \(photos.count) interesting photos.")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer:0))
        }
    }
    
//    func updateImageView(for photo: Photo){
//        store.fetchImage(for: photo) {
//            (imageResult) -> Void in
//            
//            switch imageResult {
//            case let .success(image) :
//                    self.imageView.image = image
//            case let .failure(error) :
//                print("Error downloading image: \(error)")
//            }
//        }
//    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        //download the photo image dta ,  takes some time 
        
        store.fetchImage(for: photo) {
            (result) -> Void in
            //find the most recent index path (in case index path for photo changed
            guard
                let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else{
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            //when the request finishes, only updat teh cell if it is still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                                                        as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showPhoto"?:
                if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                    let photo = photoDataSource.photos[selectedIndexPath.row]
                
                    let destinationVC = segue.destination as! PhotoInfoViewController
                    destinationVC.photo = photo
                    destinationVC.store = store
                }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

}
