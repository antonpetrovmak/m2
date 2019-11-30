//
//  CalculatorViewModel.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

enum SectionType {
    case paymentInput(_ cells: [CellType])
    case paymentScheme(_ cells: [CellType])
}

enum CellType {
    case slider(_ viewModel: SliderTableViewCellViewModel)
    case card
    case segment
    case paymentMonth
}

protocol CalculatorViewModelProtocol {
    var sections: [SectionType] { get }
    var reloadData: (() -> Void)? { get set }
    func segmentedControlValueChanged(_ index: Int)
    func sliderDidChange(_ indexPath: IndexPath, _ value: Float)
}

struct CalculatorViewModel: CalculatorViewModelProtocol {
    
    // MARK: - CalculatorViewModelProtocol
    
    private let apartmentsSchemeBuilder = ApartmentsSchemeBuilder()
    private var apartmentsSchemeModel: ApartmentsScheme {
        return apartmentsSchemeBuilder.build()
    }
    private let factory = PaymentSchemeFactory()
    private let slidersFactory = SliderViewModelFactory()
    
    private var paymentsScheme: [PaymentSchemeCellViewModel] {
        return apartmentsSchemeModel.payments.map{ factory.makePaymentSchemeCellViewModel($0) }
    }
    
    var sections: [SectionType] {
        let sliders = slidersFactory.makeSlidersViewModels(apartmentsSchemeModel)
            .map{ CellType.slider($0) }
        let section1 : [CellType] =  sliders + [.card, .segment]
        
        let sectios2 : [CellType] = []//[.paymentMonth]
        return [.paymentInput(section1), .paymentScheme(sectios2)]
    }
    
    var reloadData: (() -> Void)?
    
    func segmentedControlValueChanged(_ index: Int) {
        let type = CreditType.init(rawValue: index) ?? .standard
        apartmentsSchemeBuilder.setCreditType(type)
        reloadData?()
    }
    
    func sliderDidChange(_ indexPath: IndexPath, _ value: Float) {
        
    }
    
}
