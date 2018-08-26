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
        cell.textLabel?.text = "\(notebookTitle) (default)"
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
    
    //actionController controller
    let actionController = UIAlertController(title: "Delete notebook", message: nil, preferredStyle: .actionSheet)
    
  
    let doMoveAndDeleteAction = UIAlertAction(title: "Move all notes and delete", style: .default) { (doMoveAndDeleteAction) in
      print("Move the notes before deleting the notebook")
      
      let notebookDeleteController = NotebookDeleteController()
      
      let navController = UINavigationController(rootViewController: notebookDeleteController)
      
      self.present(navController, animated: true, completion: nil)
    }
    
    let doNotMoveAndDeleteAction = UIAlertAction(title: "Delete all the notes", style: .destructive) { (doNotMoveAndDeleteActio) in
      print("Delete all the notes")
      
      let notebook = self.notebooks[indexPath.row]
      
      if notebook.isDefault {
        print("Failed to delete default notebook")
        
        let alertController = UIAlertController(title: "Alert", message: "You cannot delete a default notebook", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        return
      }
      
      let queue = DispatchQueue(label: "Delete Single Notebook")
      
      queue.async {
        CoreDataManager.shared.deleteSingleNotebook(notebook: notebook)
        DispatchQueue.main.async {
          self.notebooks.remove(at: indexPath.row)
          self.tableView.deleteRows(at: [indexPath], with: .middle)
          self.delegate?.didChangeNotebookList()
          
        }
      }
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
      print("Cancel")
    }
    
    actionController.addAction(doNotMoveAndDeleteAction)
    actionController.addAction(doMoveAndDeleteAction)
    actionController.addAction(cancelAction)


    present(actionController, animated: true, completion: nil)
    
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
