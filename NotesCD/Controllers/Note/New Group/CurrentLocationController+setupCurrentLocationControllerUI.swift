//
//  CurrentLocationController+setupUI.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension CurrentLocationController {

    func setupCurrentLocationControllerUI() {
      
      navigationItem.title = "Current Location"
      view.backgroundColor = .darkWhite
      
      view.addSubview(messageLabel)
      messageLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
      
     
      
      let latitudeStackView = UIStackView(arrangedSubviews: [latitude, latitudeLabel])
      latitudeStackView.distribution = .fillProportionally
      latitudeStackView.axis = .horizontal
      latitudeStackView.spacing = 10
      view.addSubview(latitudeStackView)
      
      latitudeStackView.anchor(top: messageLabel.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 40)
     
      
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
  }
}
