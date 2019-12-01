//
//  UIFontExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit


/*
 *** Helvetica Neue ***
 HelveticaNeue
 HelveticaNeue-Bold
 HelveticaNeue-BoldItalic
 HelveticaNeue-CondensedBlack
 HelveticaNeue-CondensedBold
 HelveticaNeue-Italic
 HelveticaNeue-Light
 HelveticaNeue-LightItalic
 HelveticaNeue-Medium
 HelveticaNeue-MediumItalic
 HelveticaNeue-Thin
 HelveticaNeue-ThinItalic
 HelveticaNeue-UltraLight
 HelveticaNeue-UltraLightItalic
 */

extension UIFont {
    
    enum BaseFamily {
        
        private static let baseFamilyName = "Sarabun"
        
        private static func font(_ style: String, _ size: CGFloat) -> UIFont {
            return UIFont(name: "\(baseFamilyName)-\(style)", size: size)!
        }
        
        static func Regular(_ size: CGFloat) -> UIFont {
            return font("Regular", size)
        }
        
        static func Bold(_ size: CGFloat) -> UIFont {
            return font("Bold", size)
        }
        
        static func Light(_ size: CGFloat) -> UIFont {
            return font("Light", size)
        }
        
        static func Medium(_ size: CGFloat) -> UIFont {
            return font("Medium", size)
        }
        
        static func SemiBold(_ size: CGFloat) -> UIFont {
            return font("SemiBold", size)
        }
        
        static func Italic(_ size: CGFloat) -> UIFont {
            return font("Italic", size)
        }
    }
    
}
