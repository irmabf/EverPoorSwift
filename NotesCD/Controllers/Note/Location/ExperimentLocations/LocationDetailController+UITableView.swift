//
//  LocationDetailController+UITableView.swift
//  NotesCD
//
//  Created by Irma Blanco on 27/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension LocationsDetailController {
  //MARK:- TableView  Section Header
//  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 50
//  }
  
  //MARK:- TableView Number of Sections
//  override func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 3
  }
  
  //MARK:- TableView Cell For Row
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    
    return cell
  }

}









