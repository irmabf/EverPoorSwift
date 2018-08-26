//
//  NotebookDeleteController.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class DeleteNotebookAndMoveNotesController: UIViewController {
  
  var notebooks: [Notebook]?
  
  var notes: [Note]?
  
  var delegate: DeleteNotebookAndMoveNotesControllerDelegate?
  
   var selectedNotebookRow: Int = 0
  
  let notebookPicker: UIPickerView = {
    let pV = UIPickerView()
    return pV
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    notebooks = CoreDataManager.shared.fetchNotebooks()
    notebookPicker.dataSource = self
    notebookPicker.delegate = self

    setupUI()
  }
  
  fileprivate func setupUI() {
    
    view.backgroundColor = .darkGrey
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Select Notebook"
    
    let cancelBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-cancel").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleCancel))
    let selectBtn = UIBarButtonItem(title: "Move Notes", style: .plain, target: self, action: #selector(handleMoveNotes))
    view.addSubview(notebookPicker)
    
    navigationItem.leftBarButtonItem = cancelBtn
    navigationItem.rightBarButtonItem = selectBtn
    
    notebookPicker.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  @objc fileprivate func handleCancel() {
    print("Trying to cancel")
    dismiss(animated: true, completion: nil)
  }
  @objc fileprivate func handleMoveNotes() {
    print("Trying to move notes")
    let newNotebook = notebooks![selectedNotebookRow]
//    delegate?.didSelectNotebook(notebook: newNotebook)
//    dismiss(animated: true, completion: nil)
    
    if let notesToMove = notes {
      
      for note in notesToMove {
        note.notebook = newNotebook
      }
      
      let queue = DispatchQueue(label: "DeleteNotebookAndMoveNotes")
      let context = CoreDataManager.shared.persistentContainer.viewContext
      
      queue.async {
        do {
          try context.save()
          DispatchQueue.main.async {
            self.delegate?.didMoveNotes(to: newNotebook)
          }
          
        } catch let moveError {
          print("Failed to move notes:", moveError)
        }
      }
    }
    
    dismiss(animated: true, completion: nil)
  }
}











