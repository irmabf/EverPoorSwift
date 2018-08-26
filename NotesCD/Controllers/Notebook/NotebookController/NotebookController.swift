//
//  NotebookController.swift
//  NotesCD
//
//  Created by Irma Blanco on 19/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class NotebookController: UIViewController  {
  
  //MARK:- Properties
  
  var notebook: Notebook? {
    didSet {
      self.titleTextField.text = notebook?.title
    }
  }
  var delegate: NotebookControllerDelegate?
  
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Title"
    label.textColor = .darkOrange
    return label
  }()
  
  var titleTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Write notebook title"
    tf.tintColor = .darkGrey
    return tf
  }()
  
  //MARK:- Lifecycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = "Create a New Notebook"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextField.becomeFirstResponder()
    setupUI()
  }
  
  //MARK:- Actions

  @objc fileprivate func handleSave() {
    print("Trying to save  notebook")
    
    if notebook == nil {
      createNotebook()
    }else {
      updateNotebook()
    }
  }
  
  @objc fileprivate func handleCancel(){
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func createNotebook(){
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let notebook = NSEntityDescription.insertNewObject(forEntityName: "Notebook", into: context)
    
    notebook.setValue(titleTextField.text, forKey: "title")
    
    do {
      try context.save()
      dismiss(animated: true)  {
        self.delegate?.didAddNotebook(notebook: notebook as! Notebook)
      }
    } catch let saveErr {
      print("Failed to save new notebook to Core Data:", saveErr)
    }
  }

  fileprivate func updateNotebook(){
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    notebook?.title = titleTextField.text
    
    do {
      try context.save()
      dismiss(animated: true) {
        self.delegate?.didEditNotebook(notebook: self.notebook!)
      }
    } catch let updateErr {
      print("Failed to update notebook:", updateErr)
    }
  }
  
  fileprivate func setupUI(){
    view.backgroundColor = .darkWhite
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-cancel").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-save").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleSave))
    
    let goldenOrangeBackgroundView = setupGoldenOrangeBackgroundView(height: 50)
    
    let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
    stackView.distribution = .fillProportionally
    stackView.axis = .horizontal
    stackView.spacing = 10
    view.addSubview(stackView)
    stackView.anchor(top: goldenOrangeBackgroundView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, width: 0, height: 50)
  }
}
