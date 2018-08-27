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
  let locationManager = CLLocationManager()
  var location: CLLocation?
  var updatingLocation = false
  var lastLocationError: Error?
  
  //MARK:- Reverse Geocoding
  let geocoder = CLGeocoder()
  var placemark: CLPlacemark?
  var performingReverseGeocoding = false
  var lastGeocodingError: Error?
  
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
    }
  }
  
  //MARK:- Location Subviews
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.text = "(Message Label)"
    label.textAlignment = .center
    label.backgroundColor = .goldenOrange
    return label
  }()
  
  let latitude: UILabel = {
    let label = UILabel()
    label.text = "Latitude:"
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let latitudeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkOrange
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 16)
    //    label.text = "(Latitude goes here)"
    return label
  }()
  
  let longitude: UILabel = {
    let label = UILabel()
    label.text = "Longitude:"
    label.textColor = .darkOrange
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  let longitudeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 16)
    //    label.text = "(Longitude goes here)"
    return label
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .onixGrey
    label.textColor = .darkOrange
    label.numberOfLines = 0
    return label
  }()
  
  let getButton: UIButton = {
    let btn = UIButton()
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.backgroundColor = .darkGreen
    btn.setTitle("Get my location", for: .normal)
    btn.setTitleColor(.darkWhite, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    btn.addTarget(self, action: #selector(handleGetLocation), for: .touchUpInside)
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
  
  var imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "placeholder")
    iv.contentMode = .scaleAspectFill
    iv.translatesAutoresizingMaskIntoConstraints = false
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
  
  //MARK:- Lifecycle
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleCloseKeyboard))
    view.addGestureRecognizer(swipeGesture)
    

    textView.becomeFirstResponder()
    setupToolbar()
    updateLabels()
    
    
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
  fileprivate func setupUI() {
  
    navigationItem.leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(handleBack))
    navigationItem.title = "Create Note"
    view.backgroundColor = .darkWhite
    setupSaveButtonInNavbar(selector: #selector(handleSaveNote))
    
    view.addSubview(messageLabel)
    messageLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
 
    let titleStackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField, notebookLabel])
    
    titleStackView.distribution = .fillProportionally
    titleStackView.axis = .horizontal
    titleStackView.spacing = 10
    
    let latitudeStackView = UIStackView(arrangedSubviews: [latitude, latitudeLabel])
    latitudeStackView.distribution = .fillProportionally
    latitudeStackView.axis = .horizontal
    latitudeStackView.spacing = 10
    view.addSubview(latitudeStackView)
    
    latitudeStackView.anchor(top: messageLabel.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 40)
    view.addSubview(titleStackView)
    
    let longitudeStackView = UIStackView(arrangedSubviews: [longitude, longitudeLabel])
    longitudeStackView.distribution = .fillProportionally
    longitudeStackView.axis = .horizontal
    longitudeStackView.spacing = 10
    view.addSubview(longitudeStackView)
    
    longitudeStackView.anchor(top: latitudeStackView.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 40)
    
    view.addSubview(addressLabel)
    addressLabel.anchor(top: longitudeStackView.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, width: 0, height: 40)
    addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    
    view.addSubview(getButton)
    getButton.anchor(top: addressLabel.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 30)
    
    titleStackView.anchor(top: getButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    
    let expirationDateStackView = UIStackView(arrangedSubviews: [expirationDateLabel, expirationDateTextField])
    
    expirationDateStackView.distribution = .fillProportionally
    expirationDateStackView.axis = .horizontal
    expirationDateStackView.spacing = 1
    
    view.addSubview(expirationDateStackView)
    
    let datesStackView = UIStackView(arrangedSubviews: [creationDateLabel, expirationDateStackView])
    
    datesStackView.distribution = .fillProportionally
    datesStackView.axis = .horizontal
    datesStackView.spacing = 1
    view.addSubview(datesStackView)
    
    
    datesStackView.anchor(top: titleStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: paddingLeft , paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    
    view.addSubview(textView)
    
    textView.anchor(top: datesStackView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    

    view.addSubview(imageView)
    
    imageView.anchor(top: textView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
  }
  
  //MARK:- Core Data Operations
  private func createNote() {
    print("Trying to create note ...")
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    //Sync view with core data model
    let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
    
    
    newNote.setValue(self.titleTextField.text, forKey: "title")
    newNote.setValue(Date(), forKey: "creationDate")
    newNote.setValue(self.expirationDatePicker.date, forKey: "expirationDate")
    newNote.setValue(self.textView.text, forKey: "text")
 
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
  
  fileprivate func setupToolbar() {
    let bar = UIToolbar()
    
    bar.barTintColor = .darkGrey
    bar.isTranslucent = false
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let imageBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "photo-camera-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleGetPicture))
    let locationBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "location-placeholder").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSelectLocation))
    bar.sizeToFit()
    bar.items = [imageBtn, space,locationBtn]
    textView.inputAccessoryView = bar
  }

  fileprivate func saveNoteChanges() {
    print("Trying to save note changes...")

    let context = CoreDataManager.shared.persistentContainer.viewContext
    //sync view with model
    note?.title = titleTextField.text
    note?.expirationDate = expirationDatePicker.date
    note?.text = textView.text

    //perform save in core data
    do {
      try context.save()
      self.delegate?.didEditNote(note: self.note!)
    } catch let saveErr {
      print("Failed to save changes to core data", saveErr)
    }
  }
  
  //MARK:- Location Services Custom Functions
  func updateLabels() {
    if let location = location {
      latitudeLabel.text = String(format: "%.8f",
                                  location.coordinate.latitude)
      longitudeLabel.text = String(format: "%.8f",
                                   location.coordinate.longitude)
     
      messageLabel.text = ""
      
      if let placemark = placemark {
        addressLabel.text = string(from: placemark)
      } else if performingReverseGeocoding {
        addressLabel.text = "Searching for Address..."
      } else if lastGeocodingError != nil {
        addressLabel.text = "Error Finding Address"
      } else {
        addressLabel.text = "No Address Found"
      }
      
    } else {
      latitudeLabel.text = ""
      longitudeLabel.text = ""
      addressLabel.text = ""
     
     
     let statusMessage: String
      if let error = lastLocationError as NSError? {
        if error.domain == kCLErrorDomain &&
          error.code == CLError.denied.rawValue {
          statusMessage = "Location Services Disabled"
        } else {
          statusMessage = "Error Getting Location"
        }
      } else if !CLLocationManager.locationServicesEnabled() {
        statusMessage = "Location Services Disabled"
      } else if updatingLocation {
        statusMessage = "Searching current location..."
      } else {

        statusMessage = "Tap Get Location to play with the Location"
      }
      messageLabel.text = statusMessage
    }
    configureGetButton()
  }
  func configureGetButton() {
    if updatingLocation {
      getButton.setTitle("Stop", for: .normal)
    } else {
      getButton.setTitle("Get My Location", for: .normal)
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
  @objc fileprivate func handleBack(){
    navigationController?.popViewController(animated: true)
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
  
  @objc fileprivate func handleSelectLocation() {
    print("Trying to select location")
    
    let mapVC = MapViewController()
    
    mapVC.title = "Select location"
    navigationController?.pushViewController(mapVC, animated: true)
  }
  
  @objc fileprivate func handleSelectNotebook(){
    print("Trying to select a notebook")
  }
  
  @objc fileprivate func handleGetLocation(){
    print("Get location")
    
    // Handling Permissions
    let authStatus = CLLocationManager.authorizationStatus()
    if authStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
      return
    }
    
    if authStatus == .denied || authStatus == .restricted {
      showLocationServicesDeniedAlert()
      return
    }
    if updatingLocation {
      stopLocationManager()
    } else {
      location = nil
      lastLocationError = nil
      placemark = nil
      lastLocationError = nil
      startLocationManager()
    }
    updateLabels()
  }
  
  @objc fileprivate func handleGoToLocationsDetail() {
    print("Trying to go to locations")
  }
  
  @objc fileprivate func handleCloseKeyboard() {
    if titleTextField.isFirstResponder {
      titleTextField.resignFirstResponder()
    }
    if textView.isFirstResponder {
      textView.resignFirstResponder()
    }
  }
  
  @objc private func handleGetPicture() {
    print("Trying to get picture...")
    
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    
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
  
}













