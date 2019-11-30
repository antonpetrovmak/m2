//
//  ApartmentsScheme.swift
//  M2
//
//  Created by Petrov Anton on 11/18/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

struct ApartmentsScheme {
    let apartmentArea: Double
    let costOfOneQquareMeter: Double
    let apartmentCost: Double
    
    let initialFee: Double
    let initialFeePercent: Double
    
    let creditPercent: Double
    let creditTerm: Int
    
    let creditType: CreditType
    
    var creditBody: Double
    
    var payments: [OnePaymentModel]
    var limitations: Limitations
}
