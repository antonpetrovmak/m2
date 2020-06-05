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
            leftFormatter: InitialFeePercentFormatter(fullAmount: model.apartmentCost))
        
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
