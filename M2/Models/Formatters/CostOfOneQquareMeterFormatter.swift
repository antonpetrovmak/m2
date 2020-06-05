//
//  CostOfOneQquareMeterFormatter.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

struct CostOfOneQquareMeterFormatter: FormatterValueProtocol {

    var editable: Bool = true

    func format(from value: Float) -> NSAttributedString? {
        return getDefaultAttributedString(text: "\(value.currency)")
    }

    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(Int(value))")
    }

    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(Int(value))")
    }

    func formateFromEditable(from text: String) -> Float? {
        return Float(text)
    }

    func isValidInputValue(_ amount: String) -> Bool {
      let amountReg = "[1-9][0-9]{0,6}"
      let predicate = NSPredicate(format: "SELF MATCHES %@", amountReg)
      return predicate.evaluate(with: amount)
    }
}
