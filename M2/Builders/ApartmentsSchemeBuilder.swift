//
//  ApartmentsSchemeBuilder.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

struct Limitations {
    typealias Limit = (min: Double, max: Double)
    
    var apartmentArea          = Limit(1, 300)
    var costOfOneQquareMeter   = Limit(100, 1_000_000)
    var initialFee             = Limit(0, 1_000_000)
    var initialFeePercent      = Limit(0, 100)
    var creditPercent          = Limit(0, 0.5)
    var creditTerm             = Limit(0, 120)
}

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
    
    func setApartmentArea(_ area: Double) {
        apartmentArea = min(area, limitations.apartmentArea.max)
        setInitialFee(initialFee)
    }
    
    func setCostOfOneQquareMeter(_ cost: Double) {
        costOfOneQquareMeter = cost
        setInitialFee(initialFee)
    }
    
    func setInitialFee(_ initialFee: Double) {
        self.initialFee = min(initialFee, limitations.initialFee.max)
        self.initialFeePercent = initialFee == 0 ? 0 : (initialFee / apartmentCost)
    }
    
    func setInitialFeePercent(_ initialFeePercent: Double) {
        self.initialFeePercent = initialFeePercent
        self.initialFee = apartmentCost * initialFeePercent
    }
    
    func setCurrency(_ currency: CurrencyProtocol) {
        self.currency = currency
    }
    
    func setCreditType(_ creditType: CreditType) {
        self.creditType = creditType
    }
}

// MARK: - Calculable values

extension ApartmentsSchemeBuilder {
    var creditBody: Double {
        return apartmentCost - initialFee
    }
    
    private var apartmentCost: Double {
        return apartmentArea * costOfOneQquareMeter
    }
    
    private var payments: [OnePaymentModel] {
        return creditType.method.calculate(self)
    }
    
    private var limitations: Limitations {
        var limits = Limitations()
        limits.initialFee.max = apartmentCost
        return limits
    }
}

// MARK: - Builder

extension ApartmentsSchemeBuilder {
    func build() -> ApartmentsScheme {
        let model = ApartmentsScheme(apartmentArea: apartmentArea,
                                     costOfOneQquareMeter: costOfOneQquareMeter,
                                     apartmentCost: apartmentArea,
                                     initialFee: initialFee,
                                     initialFeePercent: initialFeePercent,
                                     creditPercent: creditPercent,
                                     creditTerm: creditTerm,
                                     creditType: creditType,
                                     creditBody: creditBody,
                                     payments: payments,
                                     limitations: limitations)
        return model
    }
}
