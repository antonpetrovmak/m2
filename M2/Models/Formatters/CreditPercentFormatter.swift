//
//  CreditPercentFormatter.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct CreditPercentFormatter: FormatterValueProtocol {

    var editable: Bool {
        return true
    }

    var keyboardType: UIKeyboardType {
        return .decimalPad
    }

    func format(from value: Float) -> NSAttributedString? {
        let persent = " %"
        let fullString = "\(String(format: "%g", value * 100))\(persent)"

        let attributedString = getDefaultAttributedString(text: fullString)
        [persent]
            .compactMap { fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }
        return attributedString
    }

    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(Int(value))")
    }

    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(String(format: "%g", value * 100))")
    }

    func formateFromEditable(from text: String) -> Float? {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: text) {
            return result.floatValue / 100
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: text) {
                return result.floatValue / 100
            }
        }
        return nil
    }

    func isValidInputValue(_ amount: String) -> Bool {
        let amountReg = "^[0-9]{0,2}([,.][0-9]{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", amountReg)
        return predicate.evaluate(with: amount)
    }
}
