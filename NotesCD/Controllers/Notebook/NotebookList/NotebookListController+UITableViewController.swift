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
        cell.textLabel?.text = "\(notebookTitle) ✅"
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
    
    let moveNotesAction = UITableViewRowAction(style: .default, title: "Move", handler: moveNotesHandler)
 
    
    deleteAction.backgroundColor = .darkRed
    moveNotesAction.backgroundColor = .creamYellow
    setAsDefaultAction.backgroundColor = .darkGreen
    
    return [deleteAction, moveNotesAction, setAsDefaultAction]
  }
  
  private func deleteNotebookHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    let notebook = self.notebooks[indexPath.row]
    
    if notebook.isDefault {
      let alertController = UIAlertController(title: "Alert", message: "You cannot delete a default notebook", preferredStyle: .actionSheet)
      
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(okAction)
      
      present(alertController, animated: true, completion: nil)
      return
    }
    
    let deleteController = UIAlertController(title: "Delete Notebook", message: "Are you sure you want to delete the notebook?", preferredStyle: .actionSheet)
    
    let deleteAction = UIAlertAction(title: "Yes, delete", style: .default) { (deleteAction) in
      
      let queue = DispatchQueue(label: "Delete Notebook Controller")
      queue.async {
        CoreDataManager.shared.deleteSingleNotebook(notebook: notebook)
        DispatchQueue.main.async {
          self.notebooks.remove(at: indexPath.row)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
          self.delegate?.didChangeNotebookList()
          if let delegate = self.delegate {
            delegate.didChangeNotebookList()
          }
        }
      }
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (cancelAction) in
      
    }
    
    deleteController.addAction(deleteAction)
    deleteController.addAction(cancelAction)
    
    present(deleteController, animated: true, completion: nil)
    
  }
  
  fileprivate func moveNotesHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    let notebook = notebooks[indexPath.row]
    let notesToMove = notebook.notes?.allObjects
    
    if (notesToMove?.count)! > 0 {
      let moveNotesController = MoveNotesController()
      moveNotesController.notes = notesToMove as? [Note]
      moveNotesController.delegate = self
      let navController = UINavigationController(rootViewController: moveNotesController)
      present(navController, animated: true, completion: nil)
    }
  }
  private func setAsDefaultHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    let notebook = notebooks[indexPath.row]
    CoreDataManager.shared.setDefault(notebook: notebook)
    tableView.reloadData()
    if let delegate = self.delegate {
      delegate.didChangeNotebookList()
    }
  }
  
}
