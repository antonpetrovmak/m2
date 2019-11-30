//
//  UIFont+Resize.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

extension CGFloat {
  
  private var baseWidth: CGFloat {
    return 375
    /// 768 - the base width according with the design iPad
    /// 375 - the base width according with the design iPhone
    /// return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ?  768 : 375
  }
  
  var dp: CGFloat {
    return (self / baseWidth) * UIScreen.main.bounds.width
  }
}

extension UIFont {
  var resize: UIFont {
    let newFontSize = self.pointSize.dp
    return UIFont(name: self.fontName, size: newFontSize)!
  }
}
