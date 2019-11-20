//
//  PaymentSchemeFactory.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

struct PaymentSchemeFactory {
    
    func makePaymentSchemeCellViewModel(_ model: OnePaymentModel) -> PaymentSchemeCellViewModel {
        let year: String? = (Int(model.date.stringDate(format: "MM")) == 1) ? model.date.stringDate(format: "yyyy") : nil
        return PaymentSchemeCellViewModel(
            month: model.date.stringDate(format: "MMM"),
            year: year,
            loanDebt: model.loanDebt.currency,
            loanRepayment: model.loanRepayment.currency,
            loanInterest: model.loanInterest.currency,
            commissions: "",
            paymentsPerMonth: model.paymentPerMonth.currency )
    }
}

private extension Double {
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
    
    var currency: String {
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}
