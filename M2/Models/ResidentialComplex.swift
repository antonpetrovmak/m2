//
//  ResidentialComplex.swift
//  M2
//
//  Created by Petrov Anton on 1/11/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct ResidentialComplex: Codable {
    let name: String
    let link: String
    let developerName: String
    //    let address: RCAddress
    //    let apartmentPrices: [RCApartmentPrices]
    let attributes: RCAttributes
    //    let installments: [RCInstallments]
    let credits: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case link
        case developerName = "developer_name"
        case attributes
        case credits
    }
}

struct RCCredit: Decodable {
    let rcID: String?
    let downPayment: UInt
    let term: UInt
    let ranges: [RCCreditRanges]
    
    enum CodingKeys: String, CodingKey {
        case rcID = "rc_id"
        case downPayment = "down_payment"
        case term
        case ranges
    }
    
    struct RCCreditRanges: Decodable {
        let fromMonths: UInt
        let toMonths: UInt
        let percent: Double
        
        enum CodingKeys: String, CodingKey {
            case fromMonths = "from_months"
            case toMonths = "to_months"
            case percent
        }
    }
}

struct RCInstallments {
    let downPayment: UInt //30
    let toMonths: UInt // 36
    let percent: Double
}

struct RCAttributes: Codable {
    let grade: String
}

struct RCApartmentPrices {
    let numberOfRoom: UInt
    let numberOfLevels: UInt
    let minCost: Double
    let maxCost: Double?
    let minSquares: Double
    let maxSquares: Double?
}

struct RCAddress {
    let streetName: String
    let googleMapLocation: String
}


