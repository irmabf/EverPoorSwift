//
//  NotebookListController+NoteControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebookListController {
  func didAddNote(note: Note) {
    notes.append(note)
    
//    guard let index =  notes.index(of: note) else { return }
//    IndexPath(
//    let indexToInsert = IndexPath(row: index, section: )
//    tableView.insertRows(at: [indexToInsert], with: .middle)
    tableView.reloadData()
  }
}
