//
//  InitialFeePercentFormatter.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct InitialFeePercentFormatter: FormatterValueProtocol {
    
    let fullAmount: Double
    
    var textColor: UIColor {
        return Theme.gray_BDBDBD
    }
    
    func format(from value: Float) -> NSAttributedString? {
        let persent = " %"
        let initialFeePercent = value / Float(fullAmount)
        let fullString = "\(String(format: "%.1f", initialFeePercent * 100))\(persent)"
        
        let attributedString = getDefaultAttributedString(text: fullString)
        [persent]
            .compactMap{ fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }
        return attributedString
    }
}
