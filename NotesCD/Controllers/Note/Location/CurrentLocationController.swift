//
//  CurrentLocationController.swift
//  NotesCD
//
//  Created by Irma Blanco on 26/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationController: UIViewController {
  
 //MARK:- Properties
  
  //CLLocationManager gives us the GPS coordinates
  let locationManager = CLLocationManager()
  var location: CLLocation?
  var updatingLocation = false
  var lastLocationError: Error?
  
  let geocoder = CLGeocoder()
  var placemark: CLPlacemark?
  var performingReverseGeocoding = false
  var lastGeocodingError: Error?
  
  //MARK:- Subviews
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.text = "(Message Label)"
    label.textAlignment = .center
    label.backgroundColor = .creamYellow
    return label
  }()
  
  let latitude: UILabel = {
    let label = UILabel()
    label.text = "Latitude:"
    return label
  }()
  
  let latitudeLabel: UILabel = {
    let label = UILabel()
//    label.text = "(Latitude goes here)"
    return label
  }()
  
  let longitude: UILabel = {
    let label = UILabel()
    label.text = "Longitude:"
    return label
  }()
  
  let longitudeLabel: UILabel = {
    let label = UILabel()
//    label.text = "(Longitude goes here)"
    return label
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  
  let tagButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("Tag Location", for: .normal)
    btn.setTitleColor(.onixGrey, for: .normal)
    return btn
  }()
  let getButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("Get my location", for: .normal)
    btn.setTitleColor(.onixGrey, for: .normal)
    btn.addTarget(self, action: #selector(handleGetLocation), for: .touchUpInside)
    return btn
  }()
  
  //MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupUI()
    updateLabels()
  }
  
  //MARK:- Action handlers
  @objc fileprivate func handleGetLocation() {
    let authStatus = CLLocationManager.authorizationStatus()
    
    if authStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
      return
    }
    if authStatus == .denied || authStatus == .restricted {
      showLocationServicesDenied()
      return
    }
    // Start/stop location updates
    if updatingLocation {
      stopLocationManager()
    } else {
      location = nil
      lastLocationError = nil
//      placemark = nil
//      lastGeocodingError = nil
      if updatingLocation {
        stopLocationManager()
      } else {
        location = nil
        lastLocationError = nil
        startLocationManager()
      }
    }
    updateLabels()
  }
  
  //MARK:- Location Helpers
  func showLocationServicesDenied()  {
    let alertController = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in settings.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  func configureGetButton() {
    if updatingLocation {
      getButton.setTitle("Stop", for: .normal)
    }else{
      getButton.setTitle("Get My Location", for: .normal)
    }
  }
  
  //MARK:- Methods to handle Location Errors
  
  func stopLocationManager() {
    if updatingLocation {
      locationManager.stopUpdatingLocation()
      locationManager.delegate = nil
      updatingLocation = false
    }
  }
  
  func startLocationManager() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy =
      kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
      updatingLocation = true
    }
  }
  
  //MARK:- Custom UI Functions
  
  func updateLabels() {
    if let location = location {
      
      if let placemark = placemark {
        addressLabel.text = string(from: placemark)
      } else if performingReverseGeocoding {
        addressLabel.text = "Searching for Address..."
      } else if lastGeocodingError != nil {
        addressLabel.text = "Error Finding Address"
      } else {
        addressLabel.text = "No Address Found"
      }
      
      latitudeLabel.text = String(format: "%.8f",
                                  location.coordinate.latitude)
      longitudeLabel.text = String(format: "%.8f",
                                   location.coordinate.longitude)
      tagButton.isHidden = false
      messageLabel.text = ""
    } else {
      latitudeLabel.text = ""
      longitudeLabel.text = ""
      addressLabel.text = ""
      tagButton.isHidden = true
      

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
        statusMessage = "Searching..."
      } else {
        statusMessage = "Tap 'Get My Location' to Start"
      }
      messageLabel.text = statusMessage
    }
    
    configureGetButton()
  }
  
  //MARK:- Utils
  func string(from placemark: CLPlacemark) -> String {
    // 1
    var line1 = ""
    
    // 2
    if let s = placemark.subThoroughfare {
      line1 += s + " "
    }
    
    // 3
    if let s = placemark.thoroughfare {
      line1 += s
    }
    
    // 4
    var line2 = ""
    
    if let s = placemark.locality {
      line2 += s + " "
    }
    if let s = placemark.administrativeArea {
      line2 += s + " "
    }
    if let s = placemark.postalCode {
      line2 += s
    }
    return line1 + "\n" + line2
  }
  
  fileprivate func setupUI() {
    view.addSubview(messageLabel)
    messageLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
    
    let latitudeStackView = UIStackView(arrangedSubviews: [latitude, latitudeLabel])
    latitudeStackView.distribution = .fillProportionally
    latitudeStackView.axis = .horizontal
    latitudeStackView.spacing = 10
    view.addSubview(latitudeStackView)
    
    latitudeStackView.anchor(top: messageLabel.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
    
    let longitudeStackView = UIStackView(arrangedSubviews: [longitude, longitudeLabel])
    longitudeStackView.distribution = .fillProportionally
    longitudeStackView.axis = .horizontal
    longitudeStackView.spacing = 10
    view.addSubview(longitudeStackView)
    
    longitudeStackView.anchor(top: latitudeStackView.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
  
    view.addSubview(addressLabel)
    addressLabel.anchor(top: longitudeStackView.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
    addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    
    view.addSubview(tagButton)
    tagButton.anchor(top: addressLabel.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
    
    view.addSubview(getButton)
    getButton.anchor(top: tagButton.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
  
  }
}
