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
}
