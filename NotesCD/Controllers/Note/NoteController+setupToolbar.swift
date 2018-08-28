//
//  NoteController+setupToolbar.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NoteController {
  func setupToolbar() {
    let bar = UIToolbar()
    
    bar.barTintColor = .darkGrey
    bar.isTranslucent = false
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let imageBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "photo-camera-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleGetPicture))
    let locationBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "location-placeholder").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSelectLocation))
    bar.sizeToFit()
    bar.items = [imageBtn, space,locationBtn]
    textView.inputAccessoryView = bar
  }
}
