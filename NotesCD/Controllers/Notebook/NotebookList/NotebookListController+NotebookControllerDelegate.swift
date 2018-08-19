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
    //get the index from the selected notebook
    let row = notebooks.index(of: notebook)
    //cast the index row to a IndexPath
    let reloadIndexPath = IndexPath(row: row!, section: 0)
    //Reload the row only at the given reloadIndexPath
    tableView.reloadRows(at: [reloadIndexPath], with: .middle)
  }
}

