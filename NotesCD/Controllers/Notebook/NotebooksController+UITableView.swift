//
//  NotebookController+UITableView.swift
//  NotesCD
//
//  Created by Irma Blanco on 18/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebooksViewController {
  
  //MARK:- TableView EditActions
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
      
      //I need to get the notebook that I am swiping on
      
//      let notebook = self.notebooks[indexPath.row]
//      print("Attempting to delete notebook:", notebook.title ?? "")
//
//      //Remove the notebook from our tableview
//      //1.Pass the indexpath that I passing: indexPath
//
//      //Remove the item at the specific index or it will crash
//      self.notebooks.remove(at: indexPath.row)
//      self.tableView.deleteRows(at: [indexPath], with: .automatic)
//
//      //delete the notebook from core data
//      let context = CoreDataManager.shared.persistentContainer.viewContext
//
//      context.delete(notebook)
//
//      do{
//        try context.save()
//      }catch let deleteErr {
//        print("Failed to delete notebook:", deleteErr)
//      }
    }
    
    let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
    
    let makeDefaultAction = UITableViewRowAction(style: .default, title: "Default") { (action, indexPath) in
      
      //      let notebook = self.notebooks[indexPath.row]
      print("Attempting to set the given notebook as default")
    }
    
    deleteAction.backgroundColor = .darkRed
    editAction.backgroundColor = .darkGreen
    makeDefaultAction.backgroundColor = .creamYellow
    return [deleteAction, editAction, makeDefaultAction]
  }
  
//  
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    
//    let notesVC = NoteListViewController()
//    //🗣️🗣️🗣️❗❗❗//Send over the notebook I Press 🗣️🗣️🗣️❗❗❗
//    let notebook = self.notebooks[indexPath.row]
//    
//    //notesVC.notebook is the var notebook: Notebook? from NotesListViewController
//    //I set it to the notebook variable that I just extracted from self.notebooks[indexPath.row]
//    //🗣️🗣️🗣️❗❗❗//Send over the notebook I Press
//    notesVC.notebook = notebook
//    
//    
//    navigationController?.pushViewController(notesVC, animated: true)
//  }
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  //Edit action por "Edit" button
  private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Editing notebook in separate function ")
    
    //Instance variable that stills need to be the editNotebookController
//    let editNotebookController = CreateNotebookViewController()
//    editNotebookController.delegate = self
//    editNotebookController.notebook = notebooks[indexPath.row]
//    let navController = CustomNavigationController(rootViewController: editNotebookController)
//
//    present(navController, animated: true, completion: nil)
  }
  
  //MARK:- TableView Header
  
 
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .goldenOrange
    
    let titleLabel: UILabel = {
      let label = UILabel()
      label.text = "Swipe to manage notebooks"
      label.textColor = .darkGrey
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.boldSystemFont(ofSize: 18)
      return label
    }()
    
    view.addSubview(titleLabel)
    
    //    titleLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    return view
  }
  //MARK:- TableView EditActions
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//    cell.textLabel?.text = notebook.title
    cell.textLabel?.text = "Notebook row"
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    return cell
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
}
