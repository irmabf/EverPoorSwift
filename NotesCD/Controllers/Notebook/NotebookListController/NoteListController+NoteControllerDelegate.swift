//
//  NotebookListController+NoteControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NoteListController {
  func didAddNote(note: Note) {
    notes.append(note)
    
    tableView.reloadData()
  }
  
  func didEditNote(note: Note) {
    print("Trying to update note in notebook list...")
    
    tableView.reloadData()
//    let row = notes.index(of: note)
//    let reloadIndexPath = IndexPath(row: row!, section: 0)
//    tableView.reloadRows(at: [reloadIndexPath], with: .middle)
  }
  
}
