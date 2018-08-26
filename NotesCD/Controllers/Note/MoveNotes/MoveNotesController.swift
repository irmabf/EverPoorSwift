//
//  NotebookDeleteController.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class MoveNotesController: UIViewController {
  
  var notebooks: [Notebook]?
  
  var notes: [Note]?
  
  var delegate: MoveNotesControllerDelegate?
  
   var selectedNotebookRow: Int = 0
  
  let notebookPicker: UIPickerView = {
    let pV = UIPickerView()
    return pV
  }()
  
  let textLabel: UILabel = {
    let tl = UILabel()
    tl.text = "Choose the new notebook and Save"
    tl.textColor = .onixGrey
    return tl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    notebooks = CoreDataManager.shared.fetchNotebooks()
    notebookPicker.dataSource = self
    notebookPicker.delegate = self

    setupUI()
  }
  
  fileprivate func setupUI() {
    
    view.backgroundColor = .darkWhite
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Move your notes"
   
    let cancelBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-cancel").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleCancel))

    let moveAndSaveBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-save"), style: .plain, target: self, action: #selector(handleMoveNotes))
    
    
    navigationItem.leftBarButtonItem = cancelBtn
    navigationItem.rightBarButtonItem = moveAndSaveBtn
    
    let goldenOrangeBackgroundView = setupGoldenOrangeBackgroundView(height: 50)
    goldenOrangeBackgroundView.addSubview(textLabel)
    textLabel.anchor(top: goldenOrangeBackgroundView.topAnchor, left: goldenOrangeBackgroundView.leftAnchor, bottom: goldenOrangeBackgroundView.bottomAnchor, right: goldenOrangeBackgroundView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    textLabel.centerXAnchor.constraint(equalTo: goldenOrangeBackgroundView.centerXAnchor).isActive = true
    
    view.addSubview(notebookPicker)
    
    
    notebookPicker.anchor(top: goldenOrangeBackgroundView.safeAreaLayoutGuide.bottomAnchor, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    notebookPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    notebookPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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











