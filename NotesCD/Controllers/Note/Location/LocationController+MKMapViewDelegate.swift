//
//  LocationController+MKMapViewDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 26/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import MapKit
import CoreLocation
import Contacts

extension LocationController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    let centerMapCoordinates = mapView.centerCoordinate
    let newLocationCoordinates = CLLocation(latitude: centerMapCoordinates.latitude, longitude: centerMapCoordinates.longitude)
    
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(newLocationCoordinates) { (placeMark, err) in
      
      if let places = placeMark {
        let place = places.first
        
        DispatchQueue.main.async {
           self.addressTextField.text = (place?.postalAddress?.street)! + " - " + " - " + (place?.postalCode)!
          if self.delegate != nil {
            self.delegate?.didSelectLocation(location: self.addressTextField.text!)
          }
        }
      }
    }
  }
}
