//
//  SliderViewModelFactory.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

enum SliderType: Int {
    case apartmentArea = 0
    case costOfOneQquareMeter
    case initialFee
    case creditTerm
    case creditPercent
}

struct SliderViewModelFactory {
    
    func makeSliderType(by index: Int) -> SliderType? {
        return SliderType.init(rawValue: index)
    }
    
    func makeSlidersViewModels(_ model: ApartmentsScheme) -> [SliderTableViewCellViewModel] {
        
        let apartmentArea = SliderTableViewCellViewModel(
            minimumValue: Float(model.limitations.apartmentArea.min),
            maximumValue: Float(model.limitations.apartmentArea.max),
            step: Float(model.limitations.apartmentArea.step),
            value: Float(model.apartmentArea),
            title: "title_apartment_area".localized,
            rigthFormatter: ApartmentAreaFormatter(),
            leftFormatter: nil)
        
        let costOfOneQquareMeter = SliderTableViewCellViewModel(
            minimumValue: Float(model.limitations.costOfOneQquareMeter.min),
            maximumValue: Float(model.limitations.costOfOneQquareMeter.max),
            step: Float(model.limitations.costOfOneQquareMeter.step),
            value: Float(model.costOfOneQquareMeter),
            title: "title_cost_per_square_meter".localized,
            rigthFormatter: CostOfOneQquareMeterFormatter(),
            leftFormatter: nil)
        
        let initialFee = SliderTableViewCellViewModel(
            minimumValue: Float(model.limitations.initialFee.min),
            maximumValue: Float(model.limitations.initialFee.max),
            step: Float(model.limitations.initialFee.step),
            value: Float(model.initialFee),
            title: "title_initial_fee".localized,
            rigthFormatter: InitialFeeFormatter(),
            leftFormatter: initialFeePercentFormatter(fullAmount: model.apartmentCost))
        
        let creditTerm = SliderTableViewCellViewModel(
            minimumValue: Float(model.limitations.creditTerm.min),
            maximumValue: Float(model.limitations.creditTerm.max),
            step: Float(model.limitations.creditTerm.step),
            value: Float(model.creditTerm),
            title: "title_loan_terms".localized,
            rigthFormatter: CreditTermFormatter(),
            leftFormatter: CreditTermMonthFormatter())
        
        let creditPercent = SliderTableViewCellViewModel(
            minimumValue: Float(model.limitations.creditPercent.min),
            maximumValue: Float(model.limitations.creditPercent.max),
            step: Float(model.limitations.creditPercent.step),
            value: Float(model.creditPercent),
            title: "title_interest_rate".localized,
            rigthFormatter: CreditPercentFormatter(),
            leftFormatter: nil)
        
        return [apartmentArea, costOfOneQquareMeter, initialFee, creditTerm, creditPercent]
    }
}

struct ApartmentAreaFormatter: FormatterValueProtocol {
    
    var editable: Bool {
        return true
    }
    
    var keyboardType: UIKeyboardType {
        return .decimalPad
    }
    
    func format(from value: Float) -> NSAttributedString? {
        let squareMeter = " " + "square_meter".localized
        let fullString = "\(String(format: "%g", value))\(squareMeter)"
        
        let attributedString = getDefaultAttributedString(text: fullString)
        
        [squareMeter]
            .compactMap{ fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: smallFont],
                                                       range: $0) }
        return attributedString
    }
    
    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(String(format: "%g", value))")
    }
    
    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(String(format: "%g", value))")
    }
    
    func formateFromEditable(from text: String) -> Float? {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: text) {
            return result.floatValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: text) {
                return result.floatValue
            }
        }
        return nil
    }
    
    func isValidInputValue(_ amount: String) -> Bool {
        let amountReg = "^[1-9][0-9]{0,2}([,.][0-9]{0,2})?$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", amountReg)
        return predicate.evaluate(with: amount)
    }
}

struct CostOfOneQquareMeterFormatter: FormatterValueProtocol {
    
    var editable: Bool = true
    
    func format(from value: Float) -> NSAttributedString? {
        return getDefaultAttributedString(text: "\(value.currency)")
    }
    
    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(Int(value))")
    }
    
    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(Int(value))")
    }
    
    func formateFromEditable(from text: String) -> Float? {
        return Float(text)
    }
    
    func isValidInputValue(_ amount: String) -> Bool {
      let amountReg = "[1-9][0-9]{0,6}"
      let predicate = NSPredicate(format:"SELF MATCHES %@", amountReg)
      return predicate.evaluate(with: amount)
    }
}

struct InitialFeeFormatter: FormatterValueProtocol {
    var editable: Bool = true
    
    func format(from value: Float) -> NSAttributedString? {
        return getDefaultAttributedString(text: "\(value.currency)")
    }
    
    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(Int(value))")
    }
    
    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(Int(value))")
    }
    
    func formateFromEditable(from text: String) -> Float? {
        return Float(text)
    }
    
    func isValidInputValue(_ amount: String) -> Bool {
      let amountReg = "[1-9][0-9]{0,11}"
      let predicate = NSPredicate(format:"SELF MATCHES %@", amountReg)
      return predicate.evaluate(with: amount)
    }
}

struct initialFeePercentFormatter: FormatterValueProtocol {
    
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

struct CreditTermFormatter: FormatterValueProtocol {
    private func detectYear(_ year: Int) -> String {
        let t1 = year % 10
        let t2 = year % 100
        if(t1 == 1 && t2 != 11) {
            return "yaer_1".localized
        } else if(t1 >= 2 && t1 <= 4 && (t2 < 10 || t2 >= 20)) {
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
            .compactMap{ $0 }
            .compactMap{ fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }
        
        return attributedString
    }
}

struct CreditPercentFormatter: FormatterValueProtocol {
    
    var editable: Bool {
        return true
    }
    
    var keyboardType: UIKeyboardType {
        return .decimalPad
    }
    
    func format(from value: Float) -> NSAttributedString? {
        let persent = " %"
        let fullString = "\(String(format: "%g", value * 100))\(persent)"
        
        let attributedString = getDefaultAttributedString(text: fullString)
        [persent]
            .compactMap{ fullString.nsRange(of: $0) }
            .forEach { attributedString?.addAttributes([.font: UIFont.BaseFamily.SemiBold(12).resize],
                                                      range: $0) }
        return attributedString
    }
    
    func formatPlaceholder(from value: Float) -> NSAttributedString? {
        return getPlaceholderAttributedString(text: "\(Int(value))")
    }
    
    func formateToEditable(from value: Float?) -> NSAttributedString? {
        guard let value = value else { return nil }
        return getDefaultAttributedString(text: "\(String(format: "%g", value * 100))")
    }
    
    func formateFromEditable(from text: String) -> Float? {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: text) {
            return result.floatValue / 100
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: text) {
                return result.floatValue / 100
            }
        }
        return nil
    }
    
    func isValidInputValue(_ amount: String) -> Bool {
        let amountReg = "^[0-9]{0,2}([,.][0-9]{0,2})?$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", amountReg)
        return predicate.evaluate(with: amount)
    }
}
