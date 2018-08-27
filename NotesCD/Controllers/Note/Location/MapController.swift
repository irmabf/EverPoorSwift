//
//  MapController.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
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
  }
  
  //MARK:- UI Custom Functions
  
  fileprivate func setupUI() {
    view.backgroundColor = .darkWhite
   
    view.addSubview(mapView)
    mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  //MARK:- Actions

  
}
