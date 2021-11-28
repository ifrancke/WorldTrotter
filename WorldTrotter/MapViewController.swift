//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Mac Admin on 11/26/21.
//  Copyright © 2021 Mac Admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapView : MKMapView!
    @IBOutlet var poiSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    @objc func poiDisplay(_ poiSwitch: UISwitch) {
        if poiSwitch.isOn {
            mapView.showsPointsOfInterest = false
            poiSwitch.setOn(false, animated: true)
        } else {
            mapView.showsPointsOfInterest = true
            poiSwitch.setOn(true, animated: true)
        }
    }
}
