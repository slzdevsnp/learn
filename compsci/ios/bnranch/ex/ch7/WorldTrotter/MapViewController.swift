//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Sviatoslav Zimine on 3/30/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController{
    
    
    var mapView: MKMapView!
    

    override func loadView(){
        mapView = MKMapView() //view is created in the code
        
        self.view = mapView // set mapView as a view of this ViewController
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        
        let mapTypes = [standardString, hybridString, satelliteString]
        
        let segmentedControl = UISegmentedControl(items: mapTypes)
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        //constraints
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                 constant: 8) // this sets a top margin offset
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
         
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    //action function wired to segmented control
    func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .hybrid
        case 2: mapView.mapType = .satellite
        default: break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewCotroller loaded its view")
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MapViewController is about to load")
    }
}
