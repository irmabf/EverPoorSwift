//
//  NotebookDeleteController+UIPickerViewDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension MoveNotesController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return notebooks![row].title
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    selectedNotebookRow = row
  }
}
