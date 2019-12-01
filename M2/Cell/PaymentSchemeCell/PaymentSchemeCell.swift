//
//  PaymentSchemeCell.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

class PaymentSchemeCell: UITableViewCell {
    
    @IBOutlet var month: UILabel!
    @IBOutlet var loanDebt: UILabel!            //Задолженность по кредиту
    @IBOutlet var loanRepayment: UILabel!       //Погашение кредита
    @IBOutlet var loanInterest: UILabel!        //Проценты по кредиту
    @IBOutlet var paymentsPerMonth: UILabel!    //Выплаты в месяц
    
    @IBOutlet var year: UILabel!
    @IBOutlet var yearView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        [month, loanDebt, loanRepayment, loanInterest, paymentsPerMonth]
            .forEach {
                $0?.font = UIFont.BaseFamily.Medium(12)
                $0?.textColor = Theme.gray_757F8C
        }
        
        paymentsPerMonth.textColor = Theme.red
        
        year.font = UIFont.BaseFamily.SemiBold(14)
        year.textColor = Theme.purple_613EEA
    }
    
    func setupViewModel(_ viewModel: PaymentSchemeCellViewModel) {
        month.text = viewModel.month
        loanDebt.text = viewModel.loanDebt
        loanRepayment.text = viewModel.loanRepayment
        loanInterest.text = viewModel.loanInterest
        paymentsPerMonth.text = viewModel.paymentsPerMonth
        yearView.isHidden = viewModel.year == nil
        year.text = viewModel.year
    }
    
}
