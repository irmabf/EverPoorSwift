//
//  NotebookList+UITableViewController.swift
//  NotesCD
//
//  Created by Irma Blanco on 18/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebookListController {
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
   
    let notebook = notebooks[indexPath.row]
    
    if let notebookTitle = notebook.title {
      if notebook.isDefault {
        cell.textLabel?.text = "\(notebookTitle)"
      } else {
        cell.textLabel?.text = notebookTitle
      }
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let notebookController = NotebookController()
    let notebook = notebooks[indexPath.row]
    
    notebookController.notebook = notebook
    notebookController.delegate = self
    
    let navController = UINavigationController(rootViewController: notebookController)
    present(navController, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .goldenOrange
    return view
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notebooks.count
  
  }
  
}
