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
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let newLocation = locations.last
    print("didUpdateLocations \(String(describing: newLocation))")
  }
  
}



