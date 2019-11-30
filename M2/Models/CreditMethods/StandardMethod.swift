//
//  StandardMethod.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

struct StandardMethod: CreditMethodProtocol {
    func calculate(_ dataStore: CreditDataStoreProtocol) -> [OnePaymentModel] {
        var payments = [OnePaymentModel]()
        if dataStore.creditTerm > 0 && dataStore.creditBody > 0 {
            let loanRepaymentPerMonth = dataStore.creditBody / Double(dataStore.creditTerm)
            standard(payments: &payments,
                     date: Date(),
                     loanDebt: dataStore.creditBody,
                     loanRepayment: loanRepaymentPerMonth,
                     percentPerMonth: dataStore.creditPercent/12)
        }
        return payments
    }
    
    private func standard(payments: inout [OnePaymentModel], date: Date, loanDebt: Double, loanRepayment: Double, percentPerMonth: Double) {
        
        let loanInterest = loanDebt * percentPerMonth
        
        let payment = OnePaymentModel(date: date,
                                      loanDebt: loanDebt,
                                      loanRepayment: loanRepayment,
                                      loanInterest: loanInterest,
                                      paymentPerMonth: loanRepayment + loanInterest)
        payments.append(payment)
        
        let nextLoanDebt = loanDebt - loanRepayment
        if nextLoanDebt <= 0 { return }
        
        standard(payments: &payments,
                 date: date.addMonth(1),
                 loanDebt: nextLoanDebt,
                 loanRepayment: loanRepayment,
                 percentPerMonth: percentPerMonth)
    }
}
