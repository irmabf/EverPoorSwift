//
//  NotebookListController+DeleteNotebookAndMoveNotesControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 26/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebookListController: MoveNotesControllerDelegate {
  func didSelectNotebook(notebook: Notebook) {
    
  }
  
  func didMoveNotes(to notebook: Notebook) {
    if let delegate = self.delegate {
      delegate.didChangeNotebookList()
    }
  }
  

}
