//
//  ApartmentAreaFormatter.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct ApartmentAreaFormatter: FormatterValueProtocol {

    var editable: Bool {
        return true
    }

    var keyboardType: UIKeyboardType {
        return .decimalPad
    }

    func format(from value: Float) -> NSAttributedString? {
        let squareMeter = " " + "square_meter".localized
        let fullString = "\(String(format: "%g", value))\(squareMeter)"

        let attributedString = getDefaultAttributedString(text: fullString)

        [squareMeter]
            .compactMap { fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: smallFont],
                                                       range: $0) }
        return attributedString
    }

    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(String(format: "%g", value))")
    }

    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(String(format: "%g", value))")
    }

    func formateFromEditable(from text: String) -> Float? {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: text) {
            return result.floatValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: text) {
                return result.floatValue
            }
        }
        return nil
    }

    func isValidInputValue(_ amount: String) -> Bool {
        let amountReg = "^[1-9][0-9]{0,2}([,.][0-9]{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", amountReg)
        return predicate.evaluate(with: amount)
    }
}
