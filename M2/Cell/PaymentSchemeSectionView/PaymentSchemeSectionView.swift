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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthLabel.text = "month".localized
        loanDebtLabel.text = "loan_debt".localized
        loanRepaymentLabel.text = "loan_repayment".localized
        loanInterestLabel.text = "loan_interest".localized
        payoutPerMonthLabel.text = "payout_per_month".localized
    }
}
