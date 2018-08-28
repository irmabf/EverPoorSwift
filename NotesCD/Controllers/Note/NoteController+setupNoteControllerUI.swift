//
//  NoteController+SetupUI.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NoteController {
  
  func setupNoteControllerUI() {
    
    navigationItem.leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(handleBack))
    navigationItem.title = "Create Note"
    view.backgroundColor = .darkWhite
    setupSaveButtonInNavbar(selector: #selector(handleSaveNote))
    
    
    view.addSubview(getLocationButton)
    
    getLocationButton.anchor(top: view.topAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    
    
    let titleStackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField, notebookLabel])
    
    titleStackView.distribution = .fillProportionally
    titleStackView.axis = .horizontal
    titleStackView.spacing = 10
    
    view.addSubview(titleStackView)
    
    titleStackView.anchor(top: getLocationButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
    
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
    
    imageView.anchor(top: textView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
  }
}
