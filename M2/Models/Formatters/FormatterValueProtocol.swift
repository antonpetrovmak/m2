//
//  FormatterValueProtocol.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

protocol FormatterValueProtocol {
    var editable: Bool { get }
    var placeholderFont: UIFont { get }
    var placeholderColor: UIColor { get }
    var font: UIFont { get }
    var smallFont: UIFont { get }
    var textColor: UIColor { get }
    var keyboardType: UIKeyboardType { get }
    func format(from value: Float) -> NSAttributedString?
    func formatPlaceholder(from value: Float) -> NSAttributedString?
    func formateToEditable(from value: Float?) -> NSAttributedString?
    func formateFromEditable(from text: String) -> Float?
    func isValidInputValue(_ amount: String) -> Bool
}

extension FormatterValueProtocol {
    
    var editable: Bool {
        return false
    }
    
    var font: UIFont {
        return UIFont.BaseFamily.SemiBold(32).resize
    }
    
    var smallFont: UIFont {
        return UIFont.BaseFamily.SemiBold(12).resize
    }
    
    var textColor: UIColor {
        return Theme.black
    }
    
    var placeholderFont: UIFont {
        return UIFont.BaseFamily.SemiBold(32).resize
    }
    var placeholderColor: UIColor {
        return Theme.gray_E8E9EC
    }
    
    var keyboardType: UIKeyboardType {
        return .numberPad
    }
    
    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return format(from: value)
    }
    
    func formateFromEditable(from text: String) -> Float? {
        return nil
    }
    
    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return nil
    }
    
    func isValidInputValue(_ amount: String) -> Bool {
      return false
    }
}

extension FormatterValueProtocol {
    func getDefaultAttributedString(text: String) -> NSMutableAttributedString? {
        return NSMutableAttributedString(
            string: text,
            attributes: [.font: font,
                         .foregroundColor: textColor])
    }
    
    func getPlaceholderAttributedString(text: String) -> NSMutableAttributedString? {
        return NSMutableAttributedString(
            string: text,
            attributes: [.font: placeholderFont,
                         .foregroundColor: placeholderColor])
    }
}
