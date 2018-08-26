//
//  NotebookList+UITableViewController.swift
//  NotesCD
//
//  Created by Irma Blanco on 18/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebookListController {
  
  //MARK:- CellForRow At
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
  
  //MARK:- DidSelect
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
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteNotebookHandler)
    let setAsDefaultAction = UITableViewRowAction(style: .normal, title: "Default", handler: setAsDefaultHandler)
    
    deleteAction.backgroundColor = .darkRed
    setAsDefaultAction.backgroundColor = .darkGreen
    
    return [deleteAction, setAsDefaultAction]
  }
  
  private func deleteNotebookHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to delete notebook...")
    
    let actionAlert = UIAlertController(title: "Do you want move your notes", message: "Select 'OK' if you want to save your notes before deleting the notebook", preferredStyle: .actionSheet)
    
    let doMoveAction = UIAlertAction(title: "OK", style: .default) { (okAction) in
      print("Move the notes before deleting the notebook")
      
      let notebookDeleteController = NotebookDeleteController()
      
      let navController = UINavigationController(rootViewController: notebookDeleteController)
      
      self.present(navController, animated: true, completion: nil)
      
    }
    
    let doNotMoveAction = UIAlertAction(title: "Delete all the notes", style: .destructive) { (doNoteMoveAction) in
      print("Delete all the notes")
    }
    
    actionAlert.addAction(doNotMoveAction)
    actionAlert.addAction(doMoveAction)


    
    if let delegate = self.delegate {
      delegate.didChangeNotebookList()
    }
  }
  

  fileprivate func okActionHandler() {
    print("Trying to delete selected notebook")
  }
  private func setAsDefaultHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to set default notebook...")
    
    let notebook = notebooks[indexPath.row]
    CoreDataManager.shared.setDefault(notebook: notebook)
    tableView.reloadData()
    if let delegate = self.delegate {
      delegate.didChangeNotebookList()
    }
  }
  
}
