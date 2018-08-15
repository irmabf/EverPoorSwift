//
//  NotebookListController+UITableView.swift
//  NotesCD
//
//  Created by Irma Blanco on 15/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension NotebookListController {
  
  //MARK:- TableView  Sections
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    
    let sectionTitle = "Notebook \(section + 1)"
    
    if section == 0 {
      label.text = "\(sectionTitle) ☑️"
    } else {
      label.text = sectionTitle
    }
    
    label.backgroundColor = .goldenOrange
    label.textColor = .onixGrey
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }

  //MARK:- TableView DataSource
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NotebookLisCustomCell
    
//    cell.textLabel?.text = "Notebook List Cell"
    cell.textLabel?.textColor = .darkGrey
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    let note = notes[indexPath.row]
    cell.note = note
    return cell
  }
  
}










