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

  //MARK:- TableView Number of Sections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return notebooks.count
  }
  
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
    
   let moveNoteAction = UITableViewRowAction(style: .destructive, title: "Move", handler: moveNoteHandler)
    
    
    
    deleteNoteAction.backgroundColor = .darkRed
    moveNoteAction.backgroundColor = .creamYellow
    
    return [deleteNoteAction, moveNoteAction]
  }
  

  fileprivate func moveNoteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    
    print("Trying to move a single note")
    let notebook = self.notebooks[indexPath.section]
    let notes = notebook.notes?.allObjects
    
    let note = notes![indexPath.row] as! Note
    
    let moveNotesController = MoveNotesController()
    
    moveNotesController.delegate = self
    moveNotesController.notes = [note]
    
    let navController = UINavigationController(rootViewController: moveNotesController)
    present(navController, animated: true, completion: nil)
    
  }
  fileprivate func deleteNoteHandler(action: UITableViewRowAction, indexPath: IndexPath) {
    print("Trying to delete a single note...")
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

  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let notebook = notebooks[section]
    
    let defaultMark = notebook.isDefault ? " ✅" : ""
    
    let label = IndentedLabel()
    label.backgroundColor = .goldenOrange
    
    if let notebookTitle = notebook.title {
      label.text = "\(notebookTitle)\(defaultMark)"
    }else {
      label.text = "Untitled notebook\(defaultMark)"
    }
    
    let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: label.frame.height, width: tableView.frame.width - tableView.separatorInset.right, height: 0.5))
    separatorView.backgroundColor = .separatorColor
    label.addSubview(separatorView)
    
    return label
  }


  

  
  


  

  
  

  
}

extension UIColor {
  class var separatorColor: UIColor {
    return .darkWhite
  }
}









