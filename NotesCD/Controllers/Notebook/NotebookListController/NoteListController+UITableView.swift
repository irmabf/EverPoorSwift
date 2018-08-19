//
//  NotebookListController+UITableView.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NoteListController {
  
  //MARK:- TableView  Sections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    
    let sectionTitle = "Notebook \(section + 1)"
    
    if section == 0 {
      label.text = "\(sectionTitle) ☑️"
    } else {
      label.text = sectionTitle
    }
    
    label.backgroundColor = .goldenOrange
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }
  
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  


  //MARK:- TableView DataSource
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NoteLisCustomCell
    
//    cell.textLabel?.text = "Notebook List Cell"
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    let note = notes[indexPath.row]
    cell.note = note
    return cell
  }
  
  //MARK:- Row  Selection And Edit Actions
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let note = self.notes[indexPath.row]
    let noteController = NoteController()
    noteController.note = note
    noteController.delegate = self
    navigationController?.pushViewController(noteController, animated: true)
  }
  

  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { () in
    
    let deleteNoteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteNoteHandler)
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
    //      }}
    
    
//    let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandler)
    
    let moveNoteAction = UITableViewRowAction(style: .normal, title: "Move", handler: moveNoteHandler)
    
//    let makeDefaultAction = UITableViewRowAction(style: .default, title: "Default") { (action, indexPath) in
//
//      //      let notebook = self.notebooks[indexPath.row]
//      print("Attempting to set the given notebook as default")
//    }
    
    deleteNoteAction.backgroundColor = .darkRed
    moveNoteAction.backgroundColor = .onixGrey
//    editAction.backgroundColor = .darkGreen
//    makeDefaultAction.backgroundColor = .creamYellow
    return [deleteNoteAction,moveNoteAction]
  }
  
  
  //MARK:- Row Action Handlers
  private func editHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to edit  note...")
  }
  
  private func moveNoteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to move note...")
  }
  
  
  
  private func deleteNoteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to delete note...")
    let note = self.notes[indexPath.row]
    
    // delete note from notebook list
    notes.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)
    
    // delete note from Core Data
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    //delete from the context
    context.delete(note)
     // to persist the deletion to core data persistent store
    do {
      try context.save()
    } catch let deleteError {
      print("Failed to delete note:", deleteError)
    }
  }
  
}










