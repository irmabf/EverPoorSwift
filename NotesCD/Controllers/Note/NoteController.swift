//
//  ViewController.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData

class NoteController: UIViewController {
  
  //MARK:- Properties
  var delegate: NoteControllerDelegate?
  
  var note: Note? {
    
    didSet {
      titleTextField.text = note?.title
      
      if let expirationDate = note?.expirationDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        expirationDateTextField.text = dateFormatter.string(from: expirationDate)
      }
    }
  }
  
  //MARK:- Subviews
  
  let paddingLeft: CGFloat  = 16
  let paddingRight: CGFloat = 16
  let paddingBottom: CGFloat = 0
  let paddingTop: CGFloat  = 8
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Title"
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let titleTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Write note title"
    tf.tintColor = .darkGrey
    return tf
  }()
  
  lazy var createdDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.text = "Created: mm/dd/yyyy"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeCreationDate)))
    return label
  }()
  
  lazy var expirationDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.text = "Expires: "
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeExpirationDate)))
    return label
  }()
  
  lazy var expirationDateTextField: UITextField = {
    let tf = UITextField()
    tf.textColor = .onixGrey
    tf.placeholder = "Select date"
    tf.inputView = expirationDatePicker
    return tf
  }()
  
  lazy var expirationDatePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.datePickerMode = .date
    dp.addTarget(self, action: #selector(datePickerValueChanged(datePicker: )), for: .valueChanged)
    dp.backgroundColor = .creamYellow
    dp.setValue(UIColor.darkOrange, forKey: "textColor")
    return dp
  }()
  
  
  
  let textView: UITextView = {
    let textView = UITextView()
    textView.text = ""
    textView.backgroundColor = .white
    textView.textColor = .darkGrey
    textView.font = UIFont.boldSystemFont(ofSize: 16)
    return textView
  }()
  
  let imageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "placeholder").withRenderingMode(.alwaysOriginal))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  lazy var notebookLabel: UILabel = {
    let label = UILabel()
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectNotebook)))
    label.text = "inBook: No notebook"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .darkOrange
    return label
  }()
  
  lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.text = "Location:"
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  lazy var locationTextField: UITextField = {
    let tf = UITextField()
    tf.text = "Cupertino, Santa Clara. EEUU"
    tf.isUserInteractionEnabled = true
    tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectLocation)))
    return tf
  }()
  
  //MARK:- Lifecycle
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewDidLayoutSubviews() {
    // make note's text to run around image view
    var imageArea = view.convert(imageView.frame, to: textView)
    imageArea = imageArea.insetBy(dx: -8, dy: 0)
    let path = UIBezierPath(rect: imageArea)
    textView.textContainer.exclusionPaths = [path]
    
  }
  
  //MARK:- User interaction and UI functions
  
  @objc fileprivate func handleChangeCreationDate(){
    
  }
  
  @objc private func datePickerValueChanged(datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    expirationDateTextField.text = dateFormatter.string(from: datePicker.date)
  }
  
  @objc fileprivate func handleChangeExpirationDate(){
    
  }
  fileprivate func setupUI() {
    
    navigationItem.leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(handleBack))
    
//    self.navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Create Note"
    view.backgroundColor = .darkWhite
    
//    setupCancelButtonInNavBar()
    setupSaveButtonInNavbar(selector: #selector(handleSaveNote))
 
  
  
    let titleStackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField, notebookLabel])
    
    titleStackView.distribution = .fillProportionally
    titleStackView.axis = .horizontal
    titleStackView.spacing = 10
    view.addSubview(titleStackView)
    
    
    titleStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    
    let expirationDateStackView = UIStackView(arrangedSubviews: [expirationDateLabel, expirationDateTextField])
    
    expirationDateStackView.distribution = .fillProportionally
    expirationDateStackView.axis = .horizontal
    expirationDateStackView.spacing = 1
    
    view.addSubview(expirationDateStackView)
    
    
    let datesStackView = UIStackView(arrangedSubviews: [createdDateLabel, expirationDateStackView])
    
    datesStackView.distribution = .fillProportionally
    datesStackView.axis = .horizontal
    datesStackView.spacing = 1
    view.addSubview(datesStackView)
    
    
    datesStackView.anchor(top: titleStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: paddingLeft , paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    
    
    let locationStackView = UIStackView(arrangedSubviews: [locationLabel, locationTextField])
    
    locationStackView.distribution = .fillProportionally
    locationStackView.axis = .horizontal
    locationStackView.spacing = 1
    
    view.addSubview(locationStackView)
   
    locationStackView.anchor(top: datesStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: paddingLeft, paddingBottom: 8, paddingRight: paddingRight, width: 0, height: 40)

    view.addSubview(textView)
    
    textView.anchor(top: locationStackView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    view.addSubview(imageView)
    
    imageView.anchor(top: textView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
  
  }
  
  @objc fileprivate func handleBack(){
    navigationController?.popViewController(animated: true)
  }
  
  //MARK:- Core Data Operations
  
  
  private func createNote() {
    print("Trying to create note ...")
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    //Sync view with core data model
    let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
    
    //Get the value from the titleTextField and set it as the newNote property
    //the newNoteProperty will put the object in the NSEntity waiting for the save
    newNote.setValue(titleTextField.text, forKey: "title")
    newNote.setValue(expirationDatePicker.date, forKey: "expirationDate")
    
    let defaultNotebook = CoreDataManager.shared.getDefaultNotebook()
    
    newNote.setValue(defaultNotebook, forKey: "notebook")
    
    //Now we save the context and with that the newNote
    do {
      try context.save()
      self.delegate?.didAddNote(note: newNote as! Note)
      dismiss(animated: true, completion: nil)
    } catch let createError {
      print("Failed to create a new note:", createError)
    }
  }
  
  
  @objc private func handleSaveNote() {
    // tap on Save button
    if self.note == nil {
      createNote()
    } else {
      saveNoteChanges()
    }
    navigationController?.popViewController(animated: true)
  }
  
  private func saveNoteChanges() {
    print("Trying to save note changes...")

    let context = CoreDataManager.shared.persistentContainer.viewContext
    //sync view with model
    note?.title = titleTextField.text
    note?.expirationDate = expirationDatePicker.date

    //perform save in core data
    do {
      try context.save()
      self.delegate?.didEditNote(note: self.note!)
    } catch let saveErr {
      print("Failed to save changes to core data", saveErr)
    }
  }
  
 

  

  //MARK:- Actions
  
  
  
  @objc fileprivate func handleSelectLocation() {
    print("Trying to select location")
    
    let locationController = LocationController()
    
    locationController.title = "Select location"
    locationController.address = locationTextField.text
    navigationController?.pushViewController(locationController, animated: true)
  }
  
  @objc fileprivate func handleSelectNotebook(){
    print("Trying to select a notebook")
  }
  
}













