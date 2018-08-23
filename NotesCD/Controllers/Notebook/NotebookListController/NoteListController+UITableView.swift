//
//  NotebookListController+UITableView.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NoteListController {
  
  //MARK:- TableView  Section Header
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    let defaultNotebook = CoreDataManager.shared.getDefaultNotebook()
    
    if let notebookTitle = defaultNotebook.title {
      return "\(notebookTitle) Default"
    }else {
      return "No title - Default"
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let defaultNotebook = CoreDataManager.shared.getDefaultNotebook()
    
    let label = IndentedLabel()
    label.backgroundColor = .goldenOrange
    
    if let notebookTitlte = defaultNotebook.title {
      label.text = "\(notebookTitlte) Default"
    }else {
      label.text = ""
    }
    return label
  }

  //MARK:- TableView Number of Sections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return notebooks.count
  }
  
  //MARK:- TableView numberOfRowsInSection
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //If there is any note in the given section, return the number or notes
    
    if let notesCount = notebooks[section].notes?.count {
      return notesCount
    }
    //else return 0
    return 0
  }
  
  //MARK:- TableView Cell For Row
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NoteLisCustomCell
    
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    
    let note = getNoteAtIndexPath(indexPath: indexPath)
    cell.note = note
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let note = getNoteAtIndexPath(indexPath: indexPath)
    
    let noteController = NoteController()
    
    noteController.note = note
    noteController.delegate = self
    navigationController?.pushViewController(noteController, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

      let deleteNoteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteNoteHandler)

    let moveNoteAction = UITableViewRowAction(style: .normal, title: "Move", handler: moveNoteHandler)
  
    
   
    moveNoteAction.backgroundColor = .onixGrey
    deleteNoteAction.backgroundColor = .darkRed

    return [moveNoteAction, deleteNoteAction]
  }
  
  private func moveNoteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to move note...")
  }
  
  
  private func deleteNoteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to delete note...")
    //get the indexpath of the note to delete
    let note = getNoteAtIndexPath(indexPath: indexPath)

    // delete note from Core Data
    let context = CoreDataManager.shared.persistentContainer.viewContext

    //delete from the context
    context.delete(note)
     // to persist the deletion to core data persistent store
    do {
      try context.save()
      //delete note from noteboook list
      tableView.deleteRows(at: [indexPath], with: .left)
    } catch let deleteError {
      print("Failed to delete note:", deleteError)
    }
  }

  fileprivate func getNoteAtIndexPath(indexPath: IndexPath) -> Note {
    //Get section of the given notebook and save it to the notebook variable
    let notebook = notebooks[indexPath.section]
    //Cast the set notes in the notebook as an array and save it to notes variable
    let notes = notebook.notes?.allObjects as! [Note]
    //Get every note from the notes variable
    let note = notes[indexPath.row]
    //Return the given note
    return note
    
  }
  
}










