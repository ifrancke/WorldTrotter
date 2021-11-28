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
    var mapView: MKMapView!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        mapView.isZoomEnabled = true
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        let poiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        poiLabel.text = "Points of Interest"
        poiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiLabel)
        let poiLabelTopConstraint = poiLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let poiLabelLeadingConstraint = poiLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)

        let poiSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        poiSwitch.setOn(true, animated : false)
        poiSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiSwitch)
        let poiTopConstraint = poiSwitch.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let poiLeadingConstraint = poiSwitch.leadingAnchor.constraint(equalTo: poiLabel.trailingAnchor, constant: 12)
        poiSwitch.addTarget(self,
                            action: #selector(poiDisplay(_:)),
                            for: .valueChanged)
        
        let findMe = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        findMe.setTitle("Find me", for: .normal)
        findMe.setTitleColor(UIColor.black, for: .normal)
        findMe.backgroundColor = UIColor.white
        findMe.layer.borderWidth = 1
        findMe.layer.borderColor = UIColor.black.cgColor
        findMe.layer.cornerRadius = 2
        findMe.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(findMe)
        let findMeTopConstraint = findMe.topAnchor.constraint(equalTo:poiLabel.bottomAnchor, constant: 8)
        let findMeLeadingConstraint = findMe.leadingAnchor.constraint(equalTo:margins.leadingAnchor)
        let fmButtonWidthConstraint = findMe.widthAnchor.constraint(
            equalToConstant: findMe.titleLabel!.intrinsicContentSize.width + 2.0 * 3)
        findMe.addTarget(self, action: #selector(findMe(_:)), for: .primaryActionTriggered)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        poiLabelTopConstraint.isActive = true
        poiLabelLeadingConstraint.isActive = true
        poiTopConstraint.isActive = true
        poiLeadingConstraint.isActive = true
        findMeTopConstraint.isActive = true
        findMeLeadingConstraint.isActive = true
        fmButtonWidthConstraint.isActive = true
        
    }
    
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
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break }
    }
    
    @objc func findMe(_ findMe : UIButton) {
        let coord = CLLocationCoordinate2D(latitude: 44.4779, longitude: -73.1965)
        let dist = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let mapRegion = MKCoordinateRegion(center: coord, span: dist)
        mapView.setRegion(mapRegion, animated: true)
        
    }
    
}
