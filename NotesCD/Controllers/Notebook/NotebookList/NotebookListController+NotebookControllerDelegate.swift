//
//  NotebookListController+NotebookControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 19/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebookListController: NotebookControllerDelegate {
  func didAddNotebook(notebook: Notebook) {
    notebooks.append(notebook)
    
    tableView.reloadData()
  }
  
  func didEditNotebook(notebook: Notebook) {
    
  }
  
  
}

