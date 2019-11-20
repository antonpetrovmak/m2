//
//  Currency.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

protocol CurrencyProtocol {
    var currencyCodeA: Int { get }
    var currencyCodeB: Int { get }
    var rateSell: Double { get }
    var rateBuy: Double { get }
}

struct Currency: CurrencyProtocol {
    var currencyCodeA: Int = 840
    var currencyCodeB: Int = 980
    var rateSell: Double = 24.0
    var rateBuy: Double = 24.5
}
