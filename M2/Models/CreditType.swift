
//
//  CreditType.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

enum CreditType: Int {
    case standard   = 0
    case annuity    = 1
    
    var localizedString: String {
        switch self {
        case .standard: return "standard".localized
        case .annuity: return "annuity".localized
        }
    }
    
    var method: CreditMethodProtocol {
        switch self {
        case .standard: return StandardMethod()
        case .annuity: return AnnuityMethod()
        }
    }
}
