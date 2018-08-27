//
//  CurrentLocation+CLLocationManagerDelegate .swift
//  NotesCD
//
//  Created by Irma Blanco on 27/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation
import CoreLocation

extension CurrentLocationController: CLLocationManagerDelegate  {
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("didFailedWithError \(error)")
    
    if (error as NSError).code == CLError.locationUnknown.rawValue {
      return
    }
    
    lastLocationError = error
    
    stopLocationManager()
    updateLabels()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let newLocation =  locations.last else { return }
    print("didUpdateLocations \(String(describing: newLocation))")
    
     // 1
    //  Cached result.
    
    if newLocation.timestamp.timeIntervalSinceNow < -5 {
      return
    }
     // 2
    if newLocation.horizontalAccuracy < 0 {
      return
    }
     // 3
    if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
       // 4
      lastLocationError = nil
      location = newLocation
       // 5
      if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
        print("**We are done!**")
        stopLocationManager()
      }
      updateLabels()
      if !performingReverseGeocoding {
        print("*** Going to geocode")
        
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
    }
  }
}



