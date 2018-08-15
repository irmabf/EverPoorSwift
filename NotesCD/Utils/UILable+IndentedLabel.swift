//
//  UILable+IndentedLabel.swift
//  NotesApp
//
//  Created by Irma Blanco on 13/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

class IndentedLabel: UILabel {
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    let customRect = UIEdgeInsetsInsetRect(rect, insets)
    super.drawText(in: customRect)
  }
}


