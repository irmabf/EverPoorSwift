//
//  NotebookDeleteController+UIPickerViewDataSource.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension MoveNotesController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return notebooks!.count
  }
  
}
