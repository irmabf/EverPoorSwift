//
//  CurrentLocationController+CLLocationManagerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import CoreLocation

extension CurrentLocationController: CLLocationManagerDelegate {
  
  //MARK:- didFailWithError
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("didFailWithError \(error)")
    
    if (error as NSError).code ==
      CLError.locationUnknown.rawValue {
      return
    }
    lastLocationError = error
    
    stopLocationManager()
    lastLocationError = nil
    updateLabels()
  }
  
  //MARK:- didUpdateLocations
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let newLocation = locations.last!
    print("didUpdateLocations \(newLocation)")
    
    if newLocation.timestamp.timeIntervalSinceNow < -5 {
      return
    }
    if newLocation.horizontalAccuracy < 0 {
      return
    }
    var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
    if let location = location {
      distance = newLocation.distance(from: location)
    }
    if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
      lastLocationError = nil
      location = newLocation
      if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
        stopLocationManager()
        if distance > 0 {
          performingReverseGeocoding = false
        }
      }
      updateLabels()
      if !performingReverseGeocoding {
        performingReverseGeocoding = true
        
        geocoder.reverseGeocodeLocation(newLocation, completionHandler: {
          placemarks, error in
          self.lastGeocodingError = error
          if error == nil, let p = placemarks, !p.isEmpty {
            self.placemark = p.last!
          } else {
            self.placemark = nil
          }
          
          self.performingReverseGeocoding = false
          self.updateLabels()
        })
      }
    } else if distance < 1 {
      let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
      if timeInterval > 10 {
        stopLocationManager()
        updateLabels()
      }
    }
  }
}



