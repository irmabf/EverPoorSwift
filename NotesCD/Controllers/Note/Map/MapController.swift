////
////  MapController.swift
////  NotesCD
////
////  Created by Irma Blanco on 27/08/2018.
////  Copyright © 2018 Irma Blanco. All rights reserved.
////
//
import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
  
  //MARK:- Subviews
  lazy var mapView: MKMapView = {
    let mv = MKMapView()
    mv.showsUserLocation = true
    mv.showsBuildings = true
    mv.showsPointsOfInterest = true
    mv.isZoomEnabled = true
    mv.isScrollEnabled = true
    mv.isRotateEnabled = true
    mv.showsCompass = true
    
    return mv
  }()
  
  
  
  
  //MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
//    mapView.mapType = .hybrid
//    let scale = MKScaleView(mapView: mapView)
//    scale.scaleVisibility = .visible
//    mapView.addSubview(scale)
//    scale.anchor(top: mapView.topAnchor, left: mapView.leftAnchor, bottom: nil, right: mapView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 10)
//    mapView.showsCompass = true
//    mapView.showsScale = true
  }
  
  //MARK:- UI Custom Functions
  
  fileprivate func setupUI() {
    view.backgroundColor = .darkWhite
    
    let userBtn = UIBarButtonItem(title: "User", style: .plain, target: self, action: #selector(handleShowUser))
    
    navigationItem.rightBarButtonItem = userBtn
    
    view.addSubview(mapView)
    mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  //MARK:- Actions
  @objc fileprivate func handleShowUser(){
    print("Trying to show user")
    
    let region = MKCoordinateRegionMakeWithDistance(
      mapView.userLocation.coordinate, 1, 1)
    mapView.setRegion(mapView.regionThatFits(region),
      animated: true)
  }
  
  @objc fileprivate func handleShowLocations() {
    
  }
  
}






