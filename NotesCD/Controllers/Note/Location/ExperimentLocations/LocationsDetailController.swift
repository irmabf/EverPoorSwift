//
//  TagLocationController.swift
//  NotesCD
//
//  Created by Irma Blanco on 27/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class LocationsDetailController: UITableViewController {
  
  //MARK:- Properties
  let cellId = "cellId"
  //MARK:- Subviews
  
  let descriptionTextView: UITextView = {
    let tv = UITextView()
    return tv
  }()
  
  let categoryLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let latitudeLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let longitudeLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let dateLabel: UILabel =  {
    let label = UILabel()
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .darkWhite
    navigationItem.title = "Tag new location"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    setupUI()
  }
  
  fileprivate func setupUI() {
   
  }
  
  
//  @objc fileprivate func handleDone() {
//    navigationController?.popViewController(animated: true)
//  }
//  @objc fileprivate func handleCancel() {
//    navigationController?.popViewController(animated: true)
//  }
  


  
}














