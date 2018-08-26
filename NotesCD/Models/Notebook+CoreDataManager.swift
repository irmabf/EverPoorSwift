//
//  Notebook+CoreData.swift
//  NotesCD
//
//  Created by Irma Blanco on 21/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
  
  //MARK:- Fetch Notebooks
  
  func fetchNotebooks() -> [Notebook] {
    print("Try to fetch all notebooks")
    
    let context = persistentContainer.viewContext
    
    let request = NSFetchRequest<Notebook>(entityName: "Notebook")
    
    do {
      var notebooks = try context.fetch(request)
      
      if notebooks.count == 0 {
        
        let defaultNotebook = NSEntityDescription.insertNewObject(forEntityName: "Notebook", into: context) as! Notebook
        
        defaultNotebook.setValue("Default Notebook", forKey: "title")
        defaultNotebook.setValue(true, forKey: "isDefault")
        
        
        do {
          try context.save()
        }catch let saveDefaultErr{
          print("Failed to save default:", saveDefaultErr)
        }
        
        notebooks.append(defaultNotebook)
      }
      return notebooks
    } catch let fetchErr {
      print("Failed to fetch notebooks from core data:", fetchErr)
      return []
    }
  }
  
  //MARK:- Get Default Notebook
  func getDefaultNotebook() -> Notebook {
    
    let notebooks = fetchNotebooks()
    for notebook in notebooks {
      if notebook.isDefault {
        return notebook
      }
    }
    
    fatalError("No default notebook was found")
  }
  
  
  //MARK:- Set Default Notebook
  
  func setDefault(notebook: Notebook)  {
    
    let previousDefault = getDefaultNotebook()
    let newDefault = notebook
    
    previousDefault.isDefault = false
    newDefault.isDefault = true
    
    do {
      let context = persistentContainer.viewContext
      try context.save()
    } catch let setDefaultErr {
      print("Failed to set a new default notebook:", setDefaultErr)
    }
  }
  
  //MARK:- Delete Notebooks
  
  func deleteNotebooks(completion: CleanAfterReset){
    let batchRequest = NSBatchDeleteRequest(fetchRequest: Notebook.fetchRequest())
    
    do {
      let context = persistentContainer.viewContext
      try context.execute(batchRequest)
      completion()
    } catch let deleteErr {
      print("Failed to delete notebooks:", deleteErr)
    }
  }
  
  func deleteSingleNotebook(notebook: Notebook){
    let context = persistentContainer.viewContext
    context.delete(notebook)
    
    do {
      try context.save()
    } catch let delErr {
      print("Failed to delete single notebook:", delErr)
    }
  }

}












