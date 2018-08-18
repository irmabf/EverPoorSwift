//
//  NotebookController.swift
//  NotesCD
//
//  Created by Irma Blanco on 18/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NotebooksViewController: UITableViewController {
  
  //MARK:- Properties
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    setupUI()
  }
  
  fileprivate func setupUI() {
    setupCancelButtonInNavBar()
    navigationItem.title = "Manage notebooks"
    setupTableViewStyle(tableView: tableView)
  }
}













