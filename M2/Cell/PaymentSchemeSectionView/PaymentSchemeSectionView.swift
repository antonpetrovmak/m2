//
//  PaymentSchemeSectionView.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

class PaymentSchemeSectionView: UITableViewHeaderFooterView {
    
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var loanDebtLabel: UILabel!
    @IBOutlet var loanRepaymentLabel: UILabel!
    @IBOutlet var loanInterestLabel: UILabel!
    @IBOutlet var payoutPerMonthLabel: UILabel!
    
    @IBOutlet var underStackView: UIView!
    @IBOutlet var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView?.backgroundColor = UIColor.clear
        underStackView.clipsToBounds = true
        underStackView.layer.cornerRadius = 6
        monthLabel.text = "month".localized
        loanDebtLabel.text = "loan_debt".localized
        loanRepaymentLabel.text = "loan_repayment".localized
        loanInterestLabel.text = "loan_interest".localized
        payoutPerMonthLabel.text = "payout_per_month".localized
        
        [monthLabel, loanDebtLabel, loanRepaymentLabel, loanInterestLabel, payoutPerMonthLabel]
            .forEach {
                $0?.font = UIFont.BaseFamily.Light(11).resize
                $0?.textColor = Theme.gray_4F4F4F
        }
        underStackView.addShadow(offset: CGSize(width: 0, height: 2),
                                 shadowRadius: 8,
                                 shadowOpacity: 0.1,
                                 shadowColor: Theme.black)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
}
