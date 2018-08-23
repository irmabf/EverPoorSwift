//
//  NoteListController+NotebookListControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation

extension NoteListController: NotebookListControllerDelegate {
  func didChangeNotebookList() {
   reloadNoteList()
  }
}
