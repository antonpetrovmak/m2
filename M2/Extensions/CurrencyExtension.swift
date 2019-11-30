//
//  CurrencyExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

private var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = ""
    formatter.decimalSeparator = " "
    formatter.maximumFractionDigits = 0
    formatter.minimumFractionDigits = 0
    formatter.negativeFormat = "-¤#,##0.00"
    return formatter
}

extension Double {
    var currency: String {
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}

extension Float {
    var currency: String {
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}
