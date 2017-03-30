//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Sviatoslav Zimine on 3/30/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class MapViewController : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewCotroller loaded its view")
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MapViewController is about to load")
    }
}
