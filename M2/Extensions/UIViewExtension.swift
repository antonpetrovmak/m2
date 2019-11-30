//
//  UIViewExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

extension UIView {
  
  func addShadow(offset: CGSize = CGSize(width: 0.0, height: 2.0),
                 shadowRadius: CGFloat = 2.0,
                 shadowOpacity: CGFloat = 0.3,
                 shadowColor: UIColor = UIColor.black) {
    clipsToBounds = false
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = Float(shadowOpacity)
    layer.shadowRadius = shadowRadius
    layer.shadowOffset = offset
  }
  
  func removeShadow() {
    clipsToBounds = true
    layer.shadowColor = UIColor.clear.cgColor
    layer.shadowOpacity = 0
    layer.shadowRadius = 0
    layer.shadowOffset = CGSize.zero
  }

}

