//
//  NoteController+UIImagePickerConrollerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NoteController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let originalImage = info[UIImagePickerControllerOriginalImage]
    imageView.image = (originalImage as! UIImage)
    imageView.contentMode = .scaleToFill
    
    picker.dismiss(animated: true, completion: nil)
   
  }
}
