//
//  NotebookControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 19/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import CoreData

protocol NotebookControllerDelegate {
  func didAddNotebook(notebook: Notebook)
  func didEditNotebook(notebook: Notebook)
}
