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

    func setApartmentArea(_ area: Double) {
        apartmentArea = limitations.apartmentArea.around(value: area)
        setInitialFee(initialFee)
    }

    func setCostOfOneQquareMeter(_ cost: Double) {
        costOfOneQquareMeter = limitations.costOfOneQquareMeter.around(value: cost)
        setInitialFee(initialFee)
    }

    func setInitialFee(_ initialFee: Double) {
        self.initialFee = limitations.initialFee.around(value: initialFee)
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

    func setCreditPercent(_ creditPercent: Double) {
        self.creditPercent = limitations.creditPercent.around(value: creditPercent)
    }

    func setCreditTerm(_ creditTerm: Int) {
        self.creditTerm = creditTerm
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

        let maxInitialFee = apartmentCost * 0.9
        let initialFeeStep = getInitialFeeStep(maxInitialFee)
        limits.initialFee.step = initialFeeStep
        limits.initialFee.max = (maxInitialFee / initialFeeStep) * initialFeeStep
        return limits
    }

    func getInitialFeeStep(_ apartmentCost: Double) -> Double {
        switch apartmentCost {
        case 0...100: return 10
        case 101...10_000: return 100
        case 10_001...100_000: return 1000
        case 100_001...500_000: return 5_000
        case 500_001...1_000_000: return 10_000
        case 1_000_001...3_000_000: return 10_000
        case 3_000_001...5_000_000: return 50_000
        case 5_000_001...100_000_000: return 100_000
        default: return 500_000
        }
    }
}

// MARK: - Builder

extension ApartmentsSchemeBuilder {
    func build() -> ApartmentsScheme {
        let model = ApartmentsScheme(apartmentArea: apartmentArea,
                                     costOfOneQquareMeter: costOfOneQquareMeter,
                                     apartmentCost: apartmentCost,
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
