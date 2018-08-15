//
//  UIView+helpers.swift
//  NotesApp
//
//  Created by Irma Blanco on 13/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func setupTableViewStyle(tableView: UITableView) {
  
    tableView.backgroundColor = .white
    tableView.separatorColor = .darkOrange
    tableView.tableFooterView = UIView()
    view.backgroundColor = .darkWhite
  }
  func setupPlusButtonInNavBar(selector: Selector) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-add").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: selector)
  }
  
  func setupSaveNoteButtonInNavbar(selector: Selector){
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-save"), style: .plain, target: self, action: selector)
  }
  
  func setupAddNoteButtonInNavBar(selector: Selector) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-note").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: selector)
  }
  
  
  
  func setupTrashButtonInNavbar(selector: Selector) {
   navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "trash-can").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: selector)
  }
  
  func setupSaveButtonInNavbar(selector: Selector) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-save"), style: .plain, target: self, action: selector)
  }
  func setupCancelButtonInNavBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-cancel"), style: .plain, target: self, action: #selector(handleCancelModal))
  }
  
  
  func setupBackButtonInNavBar() {
    navigationItem.leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(handleCancelModal))
  }
  @objc private func handleCancelModal() {
    dismiss(animated: true, completion: nil)
  }
  
  func setupGoldenOrangeBackgroundView(height: CGFloat) -> UIView {
    let goldenOrangeBackgroundView = UIView()
    goldenOrangeBackgroundView.backgroundColor = .goldenOrange
    
    view.addSubview(goldenOrangeBackgroundView)
    
    goldenOrangeBackgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height)
    
    return goldenOrangeBackgroundView
  }
  
}

