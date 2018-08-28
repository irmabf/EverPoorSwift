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
    
    if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
      imageView.image = editedImage
    }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = originalImage
    }
  
    dismiss(animated: true, completion: nil)
   
  }
}
