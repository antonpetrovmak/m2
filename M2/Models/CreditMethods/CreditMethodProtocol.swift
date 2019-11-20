//
//  CreditMethodProtocol.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

protocol CreditDataStoreProtocol {
    var creditBody: Double { get }
    var creditTerm: Int { get } // should be in month
    var creditPercent: Double { get } // [0.0 - 1.0] = [0;100]
}

protocol CreditMethodProtocol {
    func calculate(_ dataStore: CreditDataStoreProtocol) -> [OnePaymentModel]
}
