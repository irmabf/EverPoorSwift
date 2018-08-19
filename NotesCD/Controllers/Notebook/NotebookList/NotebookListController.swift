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
  
  override func viewDidLoad() {
    
    setupUI()
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    setupCancelButtonInNavBar()
  }
  
  //MARK:- Custoy UI Functions
  
  fileprivate func setupUI() {
    navigationItem.title = "Notebooks"
    setupTableViewStyle(tableView: tableView)
  
  }
  
  //MARK:- Actions


  
}





