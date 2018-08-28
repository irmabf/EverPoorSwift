//
//  CurrentLocationController+permissions.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension CurrentLocationController {
  //MARK:- Handling Permissions
  func showLocationServicesDeniedAlert() {
    let alertController = UIAlertController(title: "Location Services Disabled", message: "Please, enable location services for this app in settings.", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
}
