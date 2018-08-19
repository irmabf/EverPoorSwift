//
//  NotebookListController.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class NoteListController: UITableViewController, NoteControllerDelegate {

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
    tableView.register(NoteLisCustomCell.self, forCellReuseIdentifier: cellId)
  }
  
  //MARK:- SetupUI method

  fileprivate func setupUI(){
    
    setupTableViewStyle(tableView: tableView)
    
    navigationItem.title = "EverPoor"
  
    let manageNotebooksBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-book"), style: .plain, target: self, action: #selector(handleManageNotebooks))
    
    let noteBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-note"), style: .plain, target: self, action: #selector(handleLaunchAddNote))
 
   
    
    let trashBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "trash-can").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleResetData))
   
    navigationItem.leftBarButtonItems = [trashBtn, manageNotebooksBtn]
    navigationItem.rightBarButtonItem = noteBtn
  }
  
  //MARK:- Notebook Actions
  @objc private func handleManageNotebooks() {
    
    print("Trying to launch manage notebooks...")
    
    let notebookListController = UINavigationController(rootViewController: NotebookListController())
    present(notebookListController, animated: true, completion: nil)
    
  }
  
  @objc fileprivate func handleAddNotebook() {
    print("Trying to launch add notebook")
    
    let notebookController = NotebookController()
   
    let navController = UINavigationController(rootViewController: notebookController)
    present(navController, animated: true, completion: nil)
  }
  //MARK:- Notes Actions
 
  @objc fileprivate func handleLaunchAddNote() {
    let createNoteController = NoteController()
    createNoteController.delegate = self
    navigationController?.pushViewController(createNoteController, animated: true)

  }
  
  // MARK: - Action handlers
  
  @objc private func handleResetData() {
    print("Trying to reset model...")
    let alertController = UIAlertController(title: "Reset App", message: "Are you sure you want to loose all your data?", preferredStyle: .alert)
//    let actionAlert = UIAlertController(title: "Are you sure you want to reset?", message: nil, preferredStyle: .actionSheet)
    
    let okAction = UIAlertAction(title: "Yes, delete", style: .default) { (okAction) in
      CoreDataManager.shared.resetCoreData {
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








