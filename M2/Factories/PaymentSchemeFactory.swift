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
