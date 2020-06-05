//
//  ResultCardViewModelFactory.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

struct ResultCardViewModelFactory {
    func makeSlidersViewModels(_ model: ApartmentsScheme) -> ResultCardCellViewModel {

        var paymentPerMonth = ""
        var firstPayment: String?
        if !model.payments.isEmpty {
            if model.creditType == .standard {
                firstPayment = "short_first".localized + " "
                paymentPerMonth = "\(firstPayment ?? "")\(model.payments.first?.paymentPerMonth.currency ?? "")"
            } else {
                paymentPerMonth = model.payments.first?.paymentPerMonth.currency ?? ""
            }
        } else {
            paymentPerMonth = "0"
        }

        let attributedString = NSMutableAttributedString(
            string: paymentPerMonth,
            attributes: [.font: UIFont.BaseFamily.SemiBold(32).resize,
                         .foregroundColor: Theme.white])

        [firstPayment]
            .compactMap { $0 }
            .compactMap { paymentPerMonth.nsRange(of: $0) }
            .forEach { attributedString.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }

        let apartmentCost = model.apartmentCost.currency
        let loanDebt = model.creditBody.currency
        let loanInterest = model.payments
        .map { $0.loanInterest }
        .reduce(0, +)
        .currency

        return ResultCardCellViewModel(paymentPerMonth: attributedString,
                                       apartmentCost: apartmentCost,
                                       loanDebt: loanDebt,
                                       loanInterest: loanInterest)
    }
}
