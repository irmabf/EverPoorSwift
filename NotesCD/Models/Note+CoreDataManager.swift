//
//  Note+CoreDataManager.swift
//  NotesCD
//
//  Created by Irma Blanco on 21/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
  
  func fetchNotes() -> [Note] {
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
    let context = persistentContainer.viewContext
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Note.fetchRequest())
    
    do {
      try context.execute(batchDeleteRequest)
      completion()
    } catch let deleteError {
      print("Failed to delete notes:", deleteError)
    }
  }
  
}




