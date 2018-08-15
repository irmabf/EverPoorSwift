//
//  CoreDataManager.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import CoreData

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
  
}
