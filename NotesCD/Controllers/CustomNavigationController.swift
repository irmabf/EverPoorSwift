//
//  CustomNavigationController.swift
//  NotesApp
//
//  Created by Irma Blanco on 13/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .lightContent
  }
}


