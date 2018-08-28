//
//  ViewController.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class NoteController: UIViewController {
  
  //MARK:- Properties
  var delegate: NoteControllerDelegate?
 
  //MARK:- Paddings
  let paddingLeft: CGFloat  = 16
  let paddingRight: CGFloat = 16
  let paddingBottom: CGFloat = 0
  let paddingTop: CGFloat  = 8

  var note: Note? {
    
    didSet {
      titleTextField.text = note?.title
      
      let notebookTitle = note?.notebook?.title!
      notebookLabel.text = notebookTitle
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .medium
      dateFormatter.timeStyle = .none
      
      let creationDate = note?.creationDate!
      creationDateLabel.text = "Created: \(dateFormatter.string(from: creationDate!))"
      
      if let expirationDate = note?.expirationDate {
        expirationDateTextField.text = dateFormatter.string(from: expirationDate)
      }
      
      if let noteText = note?.text {
        self.textView.text = noteText
      }
      
      if let imageData = note?.image {
        imageView.image = UIImage(data: imageData)
      }
    }
  }
  
  let getLocationButton: UIButton = {
    let btn = UIButton()
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.backgroundColor = .goldenOrange
    btn.setTitle("Got to get my location", for: .normal)
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    btn.addTarget(self, action: #selector(handleLaunchGetLocation), for: .touchUpInside)
    return btn
  }()
  
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
  
  lazy var creationDateLabel: UILabel = {
    let label = UILabel()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    label.text = "Created:"
    
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    
    label.isUserInteractionEnabled = true

    return label
  }()
  
  lazy var expirationDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.text = "Expires: "
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.isUserInteractionEnabled = true
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
    textView.backgroundColor = .white
    textView.textColor = .darkGrey
    textView.font = UIFont.boldSystemFont(ofSize: 16)
    return textView
  }()
  
  lazy var imageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  lazy var notebookLabel: UILabel = {
    let label = UILabel()
    label.isUserInteractionEnabled = true
    label.text = "inBook: No notebook"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .darkOrange
    return label
  }()
  
  //MARK:- Lifecycle
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNoteControllerUI()
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleCloseKeyboard))
    view.addGestureRecognizer(swipeGesture)
    

    textView.becomeFirstResponder()
    setupToolbar()
   
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(handleAdjustForKeyBoard), name: Notification.Name.UIKeyboardWillHide, object: nil)
    notificationCenter.addObserver(self, selector: #selector(handleAdjustForKeyBoard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.isToolbarHidden = true
  }
  
  override func viewDidLayoutSubviews() {
    // make note's text to run around image view
    var imageArea = view.convert(imageView.frame, to: textView)
    imageArea = imageArea.insetBy(dx: -8, dy: 0)
    let path = UIBezierPath(rect: imageArea)
    textView.textContainer.exclusionPaths = [path]
    
  }
 
  //MARK:- Core Data Operations
  func createNote() {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    //Sync view with core data model
    let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
    
    
    newNote.setValue(self.titleTextField.text, forKey: "title")
    newNote.setValue(Date(), forKey: "creationDate")
    newNote.setValue(self.expirationDatePicker.date, forKey: "expirationDate")
    newNote.setValue(self.textView.text, forKey: "text")
    
    if let image = imageView.image {
      let imageData = UIImageJPEGRepresentation(image, 0.8)
      newNote.setValue(imageData, forKey: "image")
    }
    
    
    let defaultNotebook = CoreDataManager.shared.getDefaultNotebook()
    
    newNote.setValue(defaultNotebook, forKey: "notebook")
    
    note?.title = self.titleTextField.text
    note?.expirationDate = self.expirationDatePicker.date
    
    //Now we save the context and with that the newNote
    do {
      try context.save()
      self.delegate?.didAddNote(note: newNote as! Note)
      dismiss(animated: true, completion: nil)
    } catch let createError {
      print("Failed to create a new note:", createError)
    }
  }

  fileprivate func saveNoteChanges() {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    //sync view with model
    note?.title = titleTextField.text
    note?.expirationDate = expirationDatePicker.date
    note?.text = textView.text
    
    if let image = imageView.image {
      let imageData = UIImageJPEGRepresentation(image, 0.8)
      note?.image = imageData
    }

    //perform save in core data
    do {
      try context.save()
      self.delegate?.didEditNote(note: self.note!)
    } catch let saveErr {
      print("Failed to save changes to core data", saveErr)
    }
  }
  
  
  //MARK:- Actions
  
  @objc fileprivate func handleAdjustForKeyBoard(notification: Notification) {
    let userInfo = notification.userInfo!
    
    let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    if notification.name == Notification.Name.UIKeyboardWillHide {
      textView.contentInset = UIEdgeInsets.zero
    } else {
      textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
    }
    
    textView.scrollIndicatorInsets = textView.contentInset
    
    let selectedRange = textView.selectedRange
    textView.scrollRangeToVisible(selectedRange)
  }
  
  @objc private func datePickerValueChanged(datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    expirationDateTextField.text = dateFormatter.string(from: datePicker.date)
  }
  @objc func handleBack(){
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleSaveNote() {
    // tap on Save button
    if self.note == nil {
      createNote()
    } else {
      saveNoteChanges()
    }
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleSelectLocation() {
    let mapVC = MapViewController()
    
    mapVC.title = "Select location"
    navigationController?.pushViewController(mapVC, animated: true)
  }
  @objc fileprivate func handleCloseKeyboard() {
    if titleTextField.isFirstResponder {
      titleTextField.resignFirstResponder()
    }
    if textView.isFirstResponder {
      textView.resignFirstResponder()
    }
  }
  
  @objc func handleGetPicture() {
    let imagePicker = UIImagePickerController()
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    let actionSheetAlert = UIAlertController(title: NSLocalizedString("Add photo", comment: "Add photo"), message: nil, preferredStyle: .actionSheet)
    
    let useCamera = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
      imagePicker.sourceType = .camera
      self.present(imagePicker, animated: true, completion: nil)
    }
    
    let usePhotoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
      
      imagePicker.sourceType = .photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    actionSheetAlert.addAction(useCamera)
    actionSheetAlert.addAction(usePhotoLibrary)
    actionSheetAlert.addAction(cancel)
    
    present(actionSheetAlert, animated: true, completion: nil)
  }
  
  @objc func handleLaunchGetLocation() {
    let currentLocationController = CurrentLocationController()
//    let navController = UINavigationController(rootViewController: currentLocationController)
//    present(navController, animated: true, completion: nil)
   navigationController?.pushViewController(currentLocationController, animated: true)
  }
}













