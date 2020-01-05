//
//  CalculatorViewModel.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit
import Firebase

enum SectionType {
    case paymentInput(_ cells: [CellType])
    case paymentScheme(_ cells: [CellType])
    
    var isContainsHeader: Bool {
        switch self {
        case .paymentInput:
            return false
        case .paymentScheme:
            return true
        }
    }
}

enum CellType {
    case slider(_ viewModel: SliderTableViewCellViewModel)
    case card(_ viewModel: ResultCardCellViewModel)
    case segment(_ viewModel: CreditTypeCellViewModel)
    case paymentMonth(_ viewModel: PaymentSchemeCellViewModel)
}

protocol CalculatorViewModelProtocol {
    var sections: [SectionType] { get }
    var reloadData: (() -> Void)? { get set }
    func segmentedControlValueChanged(_ index: Int)
    func sliderDidChange(_ indexPath: IndexPath, _ value: Float)
    func sliderDidStopped(_ indexPath: IndexPath, _ value: Float)
    func rightValueDidEntered(_ indexPath: IndexPath, _ value: Float)
    func leftValueDidEntered(_ indexPath: IndexPath, _ value: Float)
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    // MARK: - CalculatorViewModelProtocol
    
    private let apartmentsSchemeBuilder = ApartmentsSchemeBuilder()
    
    private let factory = PaymentSchemeFactory()
    private let slidersFactory = SliderViewModelFactory()
    private let cardFactory = ResultCardViewModelFactory()
    private let creditTypeFactory = CreditTypeViewModelFactory()
    
    init() {
        updateSections()
    }
    
    private func updateSections() {
        
        let apartmentsSchemeModel = apartmentsSchemeBuilder.build()
        
        let sliders = slidersFactory.makeSlidersViewModels(apartmentsSchemeModel)
            .map{ CellType.slider($0) }
        
        let card = CellType.card(cardFactory.makeSlidersViewModels(apartmentsSchemeModel))
        let segment = CellType.segment(creditTypeFactory
            .makeCreditTypeCellViewModel(apartmentsSchemeModel.creditType.rawValue))
        let section1 : [CellType] =  sliders + [card, segment]
        
        let section2 = apartmentsSchemeModel.payments
            .map { factory.makePaymentSchemeCellViewModel($0) }
            .map { CellType.paymentMonth($0) }
        self.sections = [.paymentInput(section1), .paymentScheme(section2)]
    }
    
    private func updateData() {
        self.updateSections()
        reloadData?()
    }
    
    // MARK: - CalculatorViewModelProtocol
    
    var sections = [SectionType]()
    var reloadData: (() -> Void)?
    
    func segmentedControlValueChanged(_ index: Int) {
        let type = CreditType.init(rawValue: index) ?? .standard
        Analytics.logEvent("changed_credit_type",
                           parameters: ["to": "\(index == 0 ? "standard" : "annuity")"])
        apartmentsSchemeBuilder.setCreditType(type)
        updateData()
    }
    
    fileprivate func updateSliderValue(_ sliderType: SliderType, _ value: Float) {
        switch sliderType {
        case .apartmentArea:
            apartmentsSchemeBuilder.setApartmentArea(Double(value))
        case .costOfOneQquareMeter:
            apartmentsSchemeBuilder.setCostOfOneQquareMeter(Double(value))
        case .initialFee:
            apartmentsSchemeBuilder.setInitialFee(Double(value))
        case .creditTerm:
            apartmentsSchemeBuilder.setCreditTerm(Int(value))
        case .creditPercent:
            apartmentsSchemeBuilder.setCreditPercent(Double(value))
        }
    }
    
    func sliderDidChange(_ indexPath: IndexPath, _ value: Float) {
        guard let sliderType = slidersFactory.makeSliderType(by: indexPath.row) else { return }
        updateSliderValue(sliderType, value)
    }
    
    func sliderDidStopped(_ indexPath: IndexPath, _ value: Float) {
        guard let sliderType = slidersFactory.makeSliderType(by: indexPath.row) else { return }
        updateSliderValue(sliderType, value)
        updateData()
    }
    
    func rightValueDidEntered(_ indexPath: IndexPath, _ value: Float) {
        guard let sliderType = slidersFactory.makeSliderType(by: indexPath.row) else { return }
        updateSliderValue(sliderType, value)
        updateData()
    }
    
    func leftValueDidEntered(_ indexPath: IndexPath, _ value: Float) {
        guard let sliderType = slidersFactory.makeSliderType(by: indexPath.row) else { return }
        updateSliderValue(sliderType, value)
        updateData()
    }
}
