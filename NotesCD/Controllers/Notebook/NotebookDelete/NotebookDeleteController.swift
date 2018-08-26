//
//  NotebookDeleteController.swift
//  NotesCD
//
//  Created by Irma Blanco on 23/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class NotebookDeleteController: UIViewController {
  
  var notebooks: [Notebook]?
  
  var delegate: NotebookDeleteControllerDelegate?
  
   var selectedNotebookRow: Int = 0
  
  let notebookPicker: UIPickerView = {
    let pV = UIPickerView()
    return pV
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    notebooks = CoreDataManager.shared.fetchNotebooks()
    
    navigationItem.title = "Select Notebook to Delete"
    
    notebookPicker.dataSource = self
    notebookPicker.delegate = self
    
    
    
    setupUI()
  }
  
  fileprivate func setupUI() {
    
    view.backgroundColor = .darkGrey
    
    let cancelBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-cancel").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleCancel))
    let selectBtn = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(handleSelect))
    view.addSubview(notebookPicker)
    
    navigationItem.leftBarButtonItem = cancelBtn
    navigationItem.rightBarButtonItem = selectBtn
    
    notebookPicker.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  @objc fileprivate func handleCancel() {
    print("Trying to cancel")
    dismiss(animated: true, completion: nil)
  }
  @objc fileprivate func handleSelect() {
    print("Trying to select")
    let notebook = notebooks![selectedNotebookRow]
    delegate?.didSelectNotebook(notebook: notebook)
    dismiss(animated: true, completion: nil)
  }
}











