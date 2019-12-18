//
//  AnnuityMethod.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

struct AnnuityMethod: CreditMethodProtocol {
    func calculate(_ dataStore: CreditDataStoreProtocol) -> [OnePaymentModel] {
        var payments = [OnePaymentModel]()
        if dataStore.creditTerm > 0 && dataStore.creditBody > 0 {
            let percentPerMonth = dataStore.creditPercent/12
            let i = percentPerMonth
            let n = Double(dataStore.creditTerm)
            var paymentPerMonth: Double = 0
            if i == 0 {
                paymentPerMonth = dataStore.creditBody / n
            } else {
                let k = (i * pow((1 + i), n))/(pow((1 + i), n) - 1)
                paymentPerMonth = dataStore.creditBody * k
            }
            annuity(payments: &payments,
                     date: Date(),
                     loanDebt: dataStore.creditBody,
                     paymentPerMonth: paymentPerMonth,
                     percentPerMonth: percentPerMonth)
        }
        return payments
    }
    
    private func annuity(payments: inout [OnePaymentModel], date: Date, loanDebt: Double, paymentPerMonth: Double, percentPerMonth: Double) {
    
        let loanInterest = loanDebt * percentPerMonth
        let loanRepayment = paymentPerMonth - loanInterest
        
        let payment = OnePaymentModel(date: date,
                                      loanDebt: loanDebt,
                                      loanRepayment: loanRepayment,
                                      loanInterest: loanInterest,
                                      paymentPerMonth: paymentPerMonth)
        payments.append(payment)
        
        let nextLoanDebt = loanDebt - loanRepayment
        guard !(nextLoanDebt.isNaN || nextLoanDebt.isInfinite) else { return }
        guard Int(nextLoanDebt) > 0 else { return }
        
        annuity(payments: &payments,
                 date: date.addMonth(1),
                 loanDebt: nextLoanDebt,
                 paymentPerMonth: paymentPerMonth,
                 percentPerMonth: percentPerMonth)
    }
}

