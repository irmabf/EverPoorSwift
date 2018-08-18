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
  
  let createdDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.text = "Created: 01/01/2018"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let expirationDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.text = "Expires: 31/12/2018"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let textView: UITextView = {
    let textView = UITextView()
    textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
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
  
  let locationLabel: UILabel = {
    let label = UILabel()
    label.text = "No location selected."
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectLocation)))
    label.textColor = .darkOrange
    return label
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
  
  fileprivate func setupUI() {
    
//    self.navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Create Note"
    view.backgroundColor = .darkWhite
    
    setupCancelButtonInNavBar()
    setupSaveButtonInNavbar(selector: #selector(handleSaveNote))
 
  
  
    let titleStackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField, notebookLabel])
    
    titleStackView.distribution = .fillProportionally
    titleStackView.axis = .horizontal
    titleStackView.spacing = 10
    view.addSubview(titleStackView)
    
    
    titleStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
    
    
    let datesStackView = UIStackView(arrangedSubviews: [createdDateLabel, expirationDateLabel])
    
    datesStackView.distribution = .fillProportionally
    datesStackView.axis = .horizontal
    datesStackView.spacing = 10
    view.addSubview(datesStackView)
    
    
    datesStackView.anchor(top: titleStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: paddingLeft , paddingBottom: 0, paddingRight: paddingRight, width: 0, height: 50)
    
    view.addSubview(locationLabel)
    
    locationLabel.anchor(top: datesStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: paddingLeft, paddingBottom: 0, paddingRight: paddingRight, width: 0, height: 50)
    
    view.addSubview(textView)
    textView.anchor(top: locationLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    view.addSubview(imageView)
    
    imageView.anchor(top: textView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
  
  }
  
  //MARK:- Core Data Operations
  
  private func createNote() {
    print("Trying to create note ...")
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
    
    //Get the value from the titleTextField and set it as the newNote property
    //the newNoteProperty will put the object in the NSEntity waiting for the save
    newNote.setValue(titleTextField.text, forKey: "title")
    
    //Now we save the context and with that the newNote
    do {
      try context.save()
      delegate?.didAddNote(note: newNote as! Note)
    } catch let createError {
      print("Failed to create a new note:", createError)
    }
  }
  
  //TODO
  private func saveNoteChanges() {
    print("Trying to save note changes...")
  }
  

  //MARK:- Actions
  @objc fileprivate func handleSaveNote(){
//    let note = Note()
//    delegate?.didAddNote(note: note)
    
    //If the note property doesnt exist, create a new one, else update it

    dismiss(animated: true, completion: {
      if self.note == nil {
        self.createNote()
      }else{
        self.saveNoteChanges()
      }
     
    })
     //Dismiss
    navigationController?.popViewController(animated: true)
  }
  
  
  @objc fileprivate func handleSelectLocation() {
    print("Trying to select location")
  }
  
  @objc fileprivate func handleSelectNotebook(){
    print("Trying to select a notebook")
  }
  
}













