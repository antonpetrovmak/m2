//
//  PaymentSchemeCellViewModel.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

struct PaymentSchemeCellViewModel {
    let month: String
    let year: String?
    let loanDebt: String            //Задолженность по кредиту
    let loanRepayment: String       //Погашение кредита
    let loanInterest: String        //Проценты по кредиту
    let commissions: String         //Комиссии
    let paymentsPerMonth: String    //Выплаты в месяц
}
