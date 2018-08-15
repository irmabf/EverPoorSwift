//
//  NotebookListController.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NotebookListController: UITableViewController {
  
  //MARK:- Properties
  let cellId = "cellId"
  
  //MARK:- Lifecycle
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setupUI()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  
  fileprivate func setupUI(){
    setupTableViewStyle(tableView: tableView)
    
    navigationItem.title = "Notebooks List"
    
    let notebookBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-book"), style: .plain, target: self, action: #selector(handleManageNotebooks))
    navigationItem.leftBarButtonItem = notebookBtn
  }
  
  @objc fileprivate func handleManageNotebooks() {
    print("Trying to manage notebooks")
  }
}








