//
//  CreditTermMonthFormatter.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct CreditTermMonthFormatter: FormatterValueProtocol {
    
    var textColor: UIColor {
        return Theme.gray_BDBDBD
    }
    
    func format(from value: Float) -> NSAttributedString? {
        let monthsStr = " " + "short_month".localized
        let fullString = "\(Int(value))" + monthsStr
        
        let attributedString = getDefaultAttributedString(text: fullString)
        [monthsStr]
            .compactMap{ $0 }
            .compactMap{ fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }
        
        return attributedString
    }
}
