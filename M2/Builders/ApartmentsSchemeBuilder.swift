//
//  ApartmentsSchemeBuilder.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

public class ApartmentsSchemeBuilder: CreditDataStoreProtocol {
    
    private(set) var currency: CurrencyProtocol = Currency()
    
    private(set) var apartmentArea: Double = 62.0
    private(set) var costOfOneQquareMeter: Double = 1500
    
    private(set) var initialFee: Double = 16740
    private(set) var initialFeePercent: Double = 0.30
    
    private(set) var creditPercent: Double = 0.18
    private(set) var creditTerm: Int = 12
    
    private(set) var creditType: CreditType = .standard
    
    // MARK: - Functions
    
    func setInitialFee(_ initialFee: Double) {
        self.initialFee = initialFee
        self.initialFeePercent = initialFee == 0 ? 0 : (initialFee / apartmentCost)
    }
    
    func setInitialFeePercent(_ initialFeePercent: Double) {
        self.initialFeePercent = initialFeePercent
        self.initialFee = apartmentCost * initialFeePercent
    }
    
    func setCurrency(_ currency: CurrencyProtocol) {
        self.currency = currency
    }
    
    func setApartmentArea(_ area: Double) {
        apartmentArea = area
    }
    
    func setCreditType(_ creditType: CreditType) {
        self.creditType = creditType
    }
}

extension ApartmentsSchemeBuilder {
    var creditBody: Double {
        return apartmentCost - initialFee
    }
    
    var apartmentCost: Double {
        return apartmentArea * costOfOneQquareMeter
    }
    
    var payments: [OnePaymentModel] {
        return creditType.method.calculate(self)
    }
    
    func annuity(payments: inout [OnePaymentModel], date: Date, loanDebt: Double, loanRepayment: Double, percentPerMonth: Double) {
    }
}
