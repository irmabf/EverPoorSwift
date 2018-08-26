//
//  LocationController.swift
//  NotesCD
//
//  Created by Irma Blanco on 26/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class LocationController: UIViewController {
  
  var address: String? {
    didSet {
      addressTextField.text = address
    }
  }
  
  var delegate: LocationControllerDelegate?
  
  var addressTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
    tf.textAlignment = .center
    return tf
  }()
  
  var mapView: MKMapView = {
    let mv = MKMapView()
    
    let initLocationCoordinates = CLLocationCoordinate2D.init(latitude: 37.3229978, longitude: -122.0321823)
    let initLocationSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: initLocationCoordinates, span: initLocationSpan)
    
   mv.setRegion(region, animated: true)
    return mv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    addressTextField.delegate = self
    
    if let initAddress = address {
      goTo(address: initAddress)
    }
    setupUI()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.isToolbarHidden = false
  }
  
  
  func goTo(address: String) {
    
    let geocoder = CLGeocoder()
    let postalAddress = CNMutablePostalAddress()
    
    postalAddress.street = address
  
    geocoder.geocodePostalAddress(postalAddress) { (placeMark, err) in
      if let marks = placeMark {
        let place = marks.first
        
        DispatchQueue.main.async {
          let region = MKCoordinateRegion(center: (place?.location?.coordinate)!, span: MKCoordinateSpan.init(latitudeDelta: 0.005, longitudeDelta: 0.005))
          
          self.mapView.setRegion(region, animated: false)
        }
      }
    }
    
    mapView.isScrollEnabled = true
  }
  
  
  fileprivate func setupUI() {
    view.addSubview(addressTextField)
    view.addSubview(mapView)
    
    
    addressTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    addressTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    addressTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    mapView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

  }
  
}















