//
//  NoteController+string.swift
//  NotesCD
//
//  Created by Irma Blanco on 27/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreLocation

extension NoteController {
  
  func newImageView(with image: UIImage) -> UIImageView {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.image = image
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }
  
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
    
    // 5
    return line1 + "\n" + line2
  }
 
}
