//
//  LocationController+UITextFieldDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 26/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreLocation
import  MapKit
import Contacts

extension LocationController: UITextFieldDelegate {
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    mapView.isScrollEnabled = false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
  
    goTo(address:textField.text!)
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}










