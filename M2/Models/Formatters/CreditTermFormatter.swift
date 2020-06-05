//
//  CreditTermFormatter.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct CreditTermFormatter: FormatterValueProtocol {
    private func detectYear(_ year: Int) -> String {
        let t1 = year % 10
        let t2 = year % 100
        if t1 == 1 && t2 != 11 {
            return "yaer_1".localized
        } else if t1 >= 2 && t1 <= 4 && (t2 < 10 || t2 >= 20) {
            return "yaers_2".localized
        }
        return "yaers_3".localized
    }

    func format(from value: Float) -> NSAttributedString? {
        let intValue = Int(value)
        let years = intValue / 12
        let months = intValue % 12

        var fullString = ""

        var yearsStr: String?
        let monthsStr = " " + "short_month".localized

        if months == 0 && years == 0 {
            fullString = "\(months)\(monthsStr)"
        } else {
            if years > 0 {
                yearsStr = " " + detectYear(years)
                fullString = "\(years)\(yearsStr ?? "")"
            }
            if months > 0 {
                fullString = "\(fullString)\(fullString.isEmpty ? "" : " ")\(months)\(monthsStr)"
            }
        }

        let attributedString = getDefaultAttributedString(text: fullString)

        [yearsStr, monthsStr]
            .compactMap { $0 }
            .compactMap { fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }

        return attributedString
    }
}
