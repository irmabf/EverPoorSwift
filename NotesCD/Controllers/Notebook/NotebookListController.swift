//
//  NotebookListController.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

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

  fileprivate func setupUI(){
    
    setupTableViewStyle(tableView: tableView)
    
    navigationItem.title = "EverPoor"
    
    let notebookBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-book"), style: .plain, target: self, action: #selector(handleManageNotebooks))
    
    let noteBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-note"), style: .plain, target: self, action: #selector(handleLaunchAddNote))
 
    navigationItem.leftBarButtonItem = notebookBtn
    navigationItem.rightBarButtonItem = noteBtn
  }
  
  @objc fileprivate func handleManageNotebooks() {
    print("Trying to manage notebooks")
  }
  
  @objc fileprivate func handleLaunchAddNote() {
    let createNoteController = NoteController()
    createNoteController.delegate = self
    let navController = UINavigationController(rootViewController: createNoteController)
    navigationController?.present(navController, animated: true, completion: nil)
  }
  
}








