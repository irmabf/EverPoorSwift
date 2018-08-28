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
    tableView.reloadData()
  }
  
  func didEditNote(note: Note) {
    let notebook = note.notebook!
    let notebookIndex = notebooks.index(of: notebook)
    let notes = notebook.notes?.allObjects as! [Note]
    let noteIndex = notes.index(of: note)
    
    let reloadIndexPath = IndexPath(row: noteIndex!, section: notebookIndex!)
    tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    
   
  }
  
}
