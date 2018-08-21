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
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
//  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    
//    let defaultNotebook = CoreDataManager.shared.getDefaultNotebook()
//    
//    if let notebookTitle = defaultNotebook.title {
//      return "\(notebookTitle) Default"
//    }else {
//      return "No title - Default"
//    }
//  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let defaultNotebook = CoreDataManager.shared.getDefaultNotebook()
    
    let label = IndentedLabel()
    label.backgroundColor = .goldenOrange
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 18)
    
    if let notebookTitlte = defaultNotebook.title {
      label.text = "\(notebookTitlte) Default"
    }else {
      label.text = "No title - Default "
    }
    

    return label


  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.notes.count
  }
  
  //MARK:- TableView DataSource
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NoteLisCustomCell
    
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    
    let note = notes[indexPath.row]
    cell.note = note
    return cell
  }
  
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

    let moveNoteAction = UITableViewRowAction(style: .normal, title: "Move", handler: moveNoteHandler)
  
    
    deleteNoteAction.backgroundColor = .darkRed
    moveNoteAction.backgroundColor = .darkGreen

    return [deleteNoteAction,moveNoteAction]
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










