//
//  NotebookDeleteController+NotebookDeleteControllerDelegate.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

protocol DeleteNotebookAndMoveNotesControllerDelegate {
  func didSelectNotebook(notebook: Notebook)
  func didMoveNotes(to notebook: Notebook)
}
