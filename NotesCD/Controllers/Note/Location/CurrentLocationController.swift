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
    label.text = "(Address Goes Here Address Goes HereAddress Goes HereAddress)"
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
    print("Trying to get location")
    
    let authStatus = CLLocationManager.authorizationStatus()
    
    if authStatus == .denied || authStatus == .restricted {
      showLocationServicesDenied()
      return
    }
    
    if authStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
      return 
    }
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    //From this moment on, the location manager object will send location updates to its
    //delegate, with is the current class, CurrentLocationController view Controller
    locationManager.startUpdatingLocation()
  }
  
  //MARK:- Location Helpers
  func showLocationServicesDenied()  {
    let alertController = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in settings.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  
  //MARK:- Custom UI Functions
  
  func updateLabels() {
    if let location = location {
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
      messageLabel.text = "Tap 'Get My Location' to Start"
    }
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
    
    view.addSubview(tagButton)
    tagButton.anchor(top: addressLabel.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
    
    view.addSubview(getButton)
    getButton.anchor(top: tagButton.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
  
  }
}
