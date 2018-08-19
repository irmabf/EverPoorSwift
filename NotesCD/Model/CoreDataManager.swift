//
//  CoreDataManager.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import CoreData

typealias CleanAfterReset = () -> ()

class CoreDataManager {
  
  static let shared = CoreDataManager()
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Notes")
    container.loadPersistentStores { (storeDescription, err) in
      if let error = err {
        fatalError("Failed to load our stores: \(error)")
      }
    }
    return container
  }()
  
  func fetchNotes() -> [Note] {
    print("Trying to fetch notes...")
    
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
    
    do {
      let notes = try context.fetch(fetchRequest)
      return notes
    } catch let fetchError {
      print("Failed to fetch notes:", fetchError)
      return []
    }
  }

  func deleteNotes(completion: CleanAfterReset) {
    print("Trying to delete notes...")
    let context = persistentContainer.viewContext
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Note.fetchRequest())
    
    do {
      try context.execute(batchDeleteRequest)
      completion()
    } catch let deleteError {
      print("Failed to delete notes:", deleteError)
    }
  }
  
  func fetchNotebooks() -> [Notebook] {
    print("Try to fetch all notebooks")
    
    let context = persistentContainer.viewContext
    
    let request = NSFetchRequest<Notebook>(entityName: "Notebook")
    
    do {
      let notebooks = try context.fetch(request)
      return notebooks
    } catch let fetchErr {
      print("Failed to fetch notebooks from core data:", fetchErr)
      return []
    }
  }
  
}







