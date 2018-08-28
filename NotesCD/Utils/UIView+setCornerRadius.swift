//
//  UIView+setCornerRadius.swift
//  NotesCD
//
//  Created by Irma Blanco on 28/08/2018.
//  Copyright © 2018 Irma Blanco. All rights reserved.
//

import UIKit

extension UIView {
  
  func setCornerRadius(amount: CGFloat, withBorderAmount borderWidthAmount: CGFloat, andColor borderColor: UIColor) {
    
    self.layer.cornerRadius = amount
    self.layer.borderWidth = borderWidthAmount
    self.layer.borderColor = borderColor.cgColor
    self.layer.masksToBounds = true
    
  }
}
