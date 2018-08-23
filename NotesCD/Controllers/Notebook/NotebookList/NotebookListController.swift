//
//  NotebookListController.swift
//  NotesCD
//
//  Created by Irma Blanco on 18/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NotebookListController: UITableViewController {
  
  // MARK: - Properties
  let cellId = "cellId"
  
  var notebooks = [Notebook]()
  
  var delegate: NotebookListControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.notebooks = CoreDataManager.shared.fetchNotebooks()
    
    setupUI()
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    setupCancelButtonInNavBar()
    setupAddNotebookButtonInNavbar(selector: #selector(handleAddNotebook))
  }
  
  //MARK:- Custoy UI Functions
  
  fileprivate func setupUI() {
    navigationItem.title = "Notebooks"
    setupTableViewStyle(tableView: tableView)
  
  }
  
  //MARK:- Actions
  @objc fileprivate func handleAddNotebook(){
    let notebookController = NotebookController()
    notebookController.delegate = self
    let navController = UINavigationController(rootViewController: notebookController)
    present(navController, animated: true, completion: nil)
  }

  
}





