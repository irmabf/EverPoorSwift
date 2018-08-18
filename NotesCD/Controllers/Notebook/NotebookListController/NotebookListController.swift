//
//  NotebookListController.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class NotebookListController: UITableViewController, NoteControllerDelegate {

  //MARK:- Model
  
  var notes = [Note]()
  
  // MARK: - Subviews
  
  let titleTextLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  //MARK:- Properties
  let cellId = "cellId"
  
  //MARK:- Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
 
    notes = CoreDataManager.shared.fetchNotes()
    setupUI()
    tableView.register(NotebookLisCustomCell.self, forCellReuseIdentifier: cellId)
  }
  
  //MARK:- SetupUI method

  fileprivate func setupUI(){
    
    setupTableViewStyle(tableView: tableView)
    
    navigationItem.title = "EverPoor"
    
    let notebookBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-book"), style: .plain, target: self, action: #selector(handleCreateNotebook))
    
    let manageNotebooksBtn = UIBarButtonItem(title: "Manage Nbooks", style: .plain, target: self, action: #selector(handleManageNotebooks))
    
    let noteBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-note"), style: .plain, target: self, action: #selector(handleLaunchAddNote))
 
    let trashBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "trash-can").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleResetData))
   
    navigationItem.leftBarButtonItems = [trashBtn, notebookBtn]
    navigationItem.rightBarButtonItems = [noteBtn, manageNotebooksBtn]
  }
  
  //MARK:- Notebook Actions
  
  @objc fileprivate func handleCreateNotebook() {
    print("Trying to manage notebooks")
    
    let alertController = UIAlertController(title: "Add Notebook", message: "Write the desired title", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alertController.addTextField { (textField) in
      textField.placeholder = "Enter title here"
    }
    present(alertController, animated: true, completion: nil)
    
  }
  
  @objc fileprivate func handleManageNotebooks() {
    let manageNotebooksController = NotebooksController()
    let navController = UINavigationController(rootViewController: manageNotebooksController)
    navigationController?.present(navController, animated: true, completion: nil)
//    let createNoteController = NoteController()
//    createNoteController.delegate = self
//    let navController = UINavigationController(rootViewController: createNoteController)
//    navigationController?.present(navController, animated: true, completion: nil)
  }
  
  //MARK:- Notes Actions
 
  @objc fileprivate func handleLaunchAddNote() {
    let createNoteController = NoteController()
    createNoteController.delegate = self
    navigationController?.pushViewController(createNoteController, animated: true)

  }
  
//  @objc fileprivate func handleResetNotes() {
//    print("Trying to reset database")
//
//    CoreDataManager.shared.deleteNotes {
//      var indexPathsToRemove = [IndexPath]()
//      for (index, _) in notes.enumerated() {
//        let indexPath = IndexPath(row: index, section: 0)
//        indexPathsToRemove.append(indexPath)
//      }
//
//      notes.removeAll()
//      tableView.deleteRows(at: indexPathsToRemove, with: .automatic)
//    }
//  }
  
  // MARK: - Action handlers
  
  @objc private func handleResetData() {
    print("Trying to reset model...")
    let alertController = UIAlertController(title: "Reset App", message: "Are you sure you want to loose all your data?", preferredStyle: .alert)
//    let actionAlert = UIAlertController(title: "Are you sure you want to reset?", message: nil, preferredStyle: .actionSheet)
    
    let okAction = UIAlertAction(title: "Yes, delete", style: .default) { (okAction) in
      CoreDataManager.shared.deleteNotes {
        var indexPathsToRemove = [IndexPath]()
        for (index, _) in self.notes.enumerated() {
          let indexPath = IndexPath(row: index, section: 0)
          indexPathsToRemove.append(indexPath)
        }
        //Remove from core data
        self.notes.removeAll()
        //Remove from the view
        self.tableView.deleteRows(at: indexPathsToRemove, with: .middle)
        print("Reset performed sucessfully...")
      }
    }
    let cancelAction = UIAlertAction(title: "No way", style: .destructive) { (cancelAction) in
      print("Reset action was canceled...")
    }

    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
   present(alertController, animated: true, completion: nil)
    
  }
  
}








