//
//  CalculatorHeaderView.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol CalculatorHeaderViewDelegate: class {
    func segmentedControlValueChanged(_ index: Int)
}

class CalculatorHeaderView: UIView {
    
    weak var delegate: CalculatorHeaderViewDelegate?
    
    private var pricePerOneMeter: SkyFloatingLabelTextField! = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "10 000"
        field.title = "cost_per_square_meter".localized
        field.text = "10 000"
        field.setDefaultTheme()
        return field
    }()
    
    private var apartmentArea: SkyFloatingLabelTextField! = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "apartment_area".localized
        field.text = "62,2"
        field.textAlignment = .right
        field.titleLabel.textAlignment = .right
        field.setDefaultTheme()
        return field
    }()
    
    private var apartmentPrice: SkyFloatingLabelTextField!  = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "apartment_cost".localized
        field.text = "126 220 000"
        field.titleLabel.textAlignment = .center
        field.textAlignment = .center
        field.setDefaultTheme()
        return field
    }()
    
    private var initialFee: SkyFloatingLabelTextField!  = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "credit_amount".localized
        field.text = "300 000"
        field.setDefaultTheme()
        return field
    }()
    
    private var initialFeePercent: SkyFloatingLabelTextField!  = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "credit_amount".localized + "(%)"
        field.text = "30%"
        field.titleLabel.textAlignment = .right
        field.textAlignment = .right
        field.setDefaultTheme()
        return field
    }()
    
    private var loanTerms: SkyFloatingLabelTextField!  = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "loan_terms".localized
        field.text = "12"
        field.setDefaultTheme()
        return field
    }()
    
    private var interestRate: SkyFloatingLabelTextField!  = {
        let field = SkyFloatingLabelTextField()
        field.placeholder = "interest_rate".localized
        field.text = "18%"
        field.titleLabel.textAlignment = .right
        field.textAlignment = .right
        field.setDefaultTheme()
        return field
    }()
    
    private var creditSegmentedControl: UISegmentedControl!  = {
        let segment = UISegmentedControl(items: [CreditType.standard.localizedString, CreditType.annuity.localizedString])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segment
    }()
    
    private func setupView() {
        addSubview(pricePerOneMeter)
        pricePerOneMeter.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([pricePerOneMeter.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                             pricePerOneMeter.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                             pricePerOneMeter.rightAnchor.constraint(equalTo: apartmentArea.leftAnchor, constant: -15),
                             pricePerOneMeter.heightAnchor.constraint(equalToConstant: 40)])
        
        addSubview(apartmentArea)
        apartmentArea.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([apartmentArea.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                             apartmentArea.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                             apartmentArea.widthAnchor.constraint(equalToConstant: 150),
                             apartmentArea.heightAnchor.constraint(equalToConstant: 40)])
        
        addSubview(apartmentPrice)
        apartmentPrice.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([apartmentPrice.topAnchor.constraint(equalTo: pricePerOneMeter.bottomAnchor, constant: 15),
                             apartmentPrice.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                             apartmentPrice.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                             apartmentPrice.heightAnchor.constraint(equalToConstant: 40)])
        
        let initialFeeLine = UIView()
        initialFeeLine.backgroundColor = .lightGray
        addSubview(initialFeeLine)
        initialFeeLine.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([initialFeeLine.topAnchor.constraint(equalTo: apartmentPrice.bottomAnchor, constant: 15),
                             initialFeeLine.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
                             initialFeeLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
                             initialFeeLine.heightAnchor.constraint(equalToConstant: 1)])
        
        addSubview(initialFee)
        initialFee.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([initialFee.topAnchor.constraint(equalTo: initialFeeLine.bottomAnchor, constant: 15),
                             initialFee.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                             initialFee.rightAnchor.constraint(equalTo: initialFeePercent.leftAnchor, constant: -15),
                             initialFee.heightAnchor.constraint(equalToConstant: 40)])
        
        addSubview(initialFeePercent)
        initialFeePercent.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([initialFeePercent.topAnchor.constraint(equalTo: initialFeeLine.bottomAnchor, constant: 15),
                             initialFeePercent.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                             initialFeePercent.widthAnchor.constraint(equalToConstant: 150),
                             initialFeePercent.heightAnchor.constraint(equalToConstant: 40)])
        
        let creditFeeLine = UIView()
        creditFeeLine.backgroundColor = .lightGray
        addSubview(creditFeeLine)
        creditFeeLine.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([creditFeeLine.topAnchor.constraint(equalTo: initialFee.bottomAnchor, constant: 15),
                             creditFeeLine.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
                             creditFeeLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
                             creditFeeLine.heightAnchor.constraint(equalToConstant: 1)])
        
        addSubview(loanTerms)
        loanTerms.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([loanTerms.topAnchor.constraint(equalTo: creditFeeLine.bottomAnchor, constant: 15),
                             loanTerms.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                             loanTerms.rightAnchor.constraint(equalTo: interestRate.leftAnchor, constant: -15),
                             loanTerms.heightAnchor.constraint(equalToConstant: 40)])
        
        addSubview(interestRate)
        interestRate.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([interestRate.topAnchor.constraint(equalTo: creditFeeLine.bottomAnchor, constant: 15),
                             interestRate.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                             interestRate.widthAnchor.constraint(equalToConstant: 150),
                             interestRate.heightAnchor.constraint(equalToConstant: 40)])
        
        addSubview(creditSegmentedControl)
        creditSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([creditSegmentedControl.topAnchor.constraint(equalTo: interestRate.bottomAnchor, constant: 15),
                             creditSegmentedControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                             creditSegmentedControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                             creditSegmentedControl.heightAnchor.constraint(equalToConstant: 40)])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func segmentedControlValueChanged(_ segment: UISegmentedControl) {
        delegate?.segmentedControlValueChanged(segment.selectedSegmentIndex)
    }

}

private extension SkyFloatingLabelTextField {
    func setDefaultTheme() {
        keyboardType = .numberPad
        titleColor = .lightGray
        selectedTitleColor = .lightGray
        textColor = .black
        selectedLineHeight = 0
        lineHeight = 0
        setTitleVisible(true)
    }
}
