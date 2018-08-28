//
//  CurrentLocationController.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class CurrentLocationController: UIViewController {
  
  //MARK:- Properties
  var delegate: NoteControllerDelegate?
  let locationManager = CLLocationManager()
  var location: CLLocation?
  var updatingLocation = false
  var lastLocationError: Error?
  
  //MARK:- Reverse Geocoding
  let geocoder = CLGeocoder()
  var placemark: CLPlacemark?
  var performingReverseGeocoding = false
  var lastGeocodingError: Error?
  
  //MARK:- Location Subviews
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.text = "(Message Label)"
    label.textAlignment = .center
    label.backgroundColor = .goldenOrange
    return label
  }()
  
  let latitude: UILabel = {
    let label = UILabel()
    label.text = "Latitude:"
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let latitudeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 16)
    //    label.text = "(Latitude goes here)"
    return label
  }()
  
  let longitude: UILabel = {
    let label = UILabel()
    label.text = "Longitude:"
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let longitudeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 16)
    //    label.text = "(Longitude goes here)"
    return label
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .onixGrey
    label.textColor = .darkOrange
    label.numberOfLines = 0
    return label
  }()
  
  let getButton: UIButton = {
    let btn = UIButton()
    btn.setCornerRadius(amount: 2.0, withBorderAmount: 2.0, andColor: .darkGreen)
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.backgroundColor = .darkGreen
    btn.setTitle("Get My Location", for: .normal)
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    btn.addTarget(self, action: #selector(handleGetLocation), for: .touchUpInside)
    return btn
  }()
  
  let tagButton: UIButton = {
    let btn = UIButton()
    btn.setCornerRadius(amount: 2.0, withBorderAmount: 2.0, andColor: .darkRed)
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.backgroundColor = .darkRed
    btn.setTitle("Tag Location", for: .normal)
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    btn.addTarget(self, action: #selector(handleGetLocation), for: .touchUpInside)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCurrentLocationControllerUI()
  }
  
  //MARK:- Location Services Custom Functions
  func updateLabels() {
    if let location = location {
      latitudeLabel.text = String(format: "%.8f",
                                  location.coordinate.latitude)
      longitudeLabel.text = String(format: "%.8f",
                                   location.coordinate.longitude)
      
      messageLabel.text = ""
      
      if let placemark = placemark {
        addressLabel.text = string(from: placemark)
      } else if performingReverseGeocoding {
        addressLabel.text = "Searching for Address..."
      } else if lastGeocodingError != nil {
        addressLabel.text = "Error Finding Address"
      } else {
        addressLabel.text = "No Address Found"
      }
      
    } else {
      latitudeLabel.text = ""
      longitudeLabel.text = ""
      addressLabel.text = ""
      
      
      let statusMessage: String
      if let error = lastLocationError as NSError? {
        if error.domain == kCLErrorDomain &&
          error.code == CLError.denied.rawValue {
          statusMessage = "Location Services Disabled"
        } else {
          statusMessage = "Error Getting Location"
        }
      } else if !CLLocationManager.locationServicesEnabled() {
        statusMessage = "Location Services Disabled"
      } else if updatingLocation {
        statusMessage = "Searching current location..."
      } else {
        
        statusMessage = "Tap Get Location to play with the Location"
      }
      messageLabel.text = statusMessage
    }
    configureGetButton()
  }
  func configureGetButton() {
    if updatingLocation {
      getButton.setTitle("Stop", for: .normal)
    } else {
      getButton.setTitle("Get My Location", for: .normal)
    }
  }
  
  @objc fileprivate func handleGetLocation(){
    // Handling Permissions
    let authStatus = CLLocationManager.authorizationStatus()
    if authStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
      return
    }
    
    if authStatus == .denied || authStatus == .restricted {
      showLocationServicesDeniedAlert()
      return
    }
    if updatingLocation {
      stopLocationManager()
    } else {
      location = nil
      lastLocationError = nil
      placemark = nil
      lastLocationError = nil
      startLocationManager()
    }
    updateLabels()
  }
  
}
