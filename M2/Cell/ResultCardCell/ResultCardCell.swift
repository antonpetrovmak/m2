//
//  ResultCardCell.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

struct ResultCardCellViewModel {
    let paymentPerMonth: NSAttributedString
    let apartmentCost: String
    let loanDebt: String
    let loanInterest: String
}

class ResultCardCell: UITableViewCell {

    @IBOutlet weak var paymentPerMonthLabel: UILabel!
    @IBOutlet weak var paymentPerMonthValueLabel: UILabel!

    @IBOutlet weak var apartmentCostLabel: UILabel!
    @IBOutlet weak var apartmentCostValueLabel: UILabel!

    @IBOutlet weak var loanDebtLabel: UILabel!
    @IBOutlet weak var loanDebtValueLabel: UILabel!

    @IBOutlet weak var loanInterestLabel: UILabel!
    @IBOutlet weak var loanInterestValueLabel: UILabel!

    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        paymentPerMonthLabel.text = "title_card_monthly_payment".localized.uppercased()
        apartmentCostLabel.text = "title_card_apartment_cost".localized.uppercased()
        loanDebtLabel.text = "title_card_body_credit".localized.uppercased()
        loanInterestLabel.text = "title_card_loan_interest".localized.uppercased()

        [paymentPerMonthLabel, apartmentCostLabel, loanDebtLabel, loanInterestLabel]
            .forEach {
                $0?.font = UIFont.BaseFamily.Light(12)
                $0?.textColor = Theme.white
        }

        paymentPerMonthValueLabel.font = UIFont.BaseFamily.SemiBold(32)
        paymentPerMonthValueLabel.textColor = Theme.white

        [apartmentCostValueLabel, loanDebtValueLabel, loanInterestValueLabel]
            .forEach {
                $0?.font = UIFont.BaseFamily.Medium(16)
                $0?.textColor = Theme.white
        }

        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 6
        cardView.subviews.forEach {
            $0.clipsToBounds = true
        }
        cardView.addShadow(offset: CGSize(width: 0, height: 8), shadowRadius: 8, shadowOpacity: 0.5, shadowColor: Theme.purple_8676FB)
    }

    func setViewModel(_ viewModel: ResultCardCellViewModel) {
        paymentPerMonthValueLabel.attributedText = viewModel.paymentPerMonth
        apartmentCostValueLabel.text = viewModel.apartmentCost
        loanDebtValueLabel.text = viewModel.loanDebt
        loanInterestValueLabel.text = viewModel.loanInterest
    }

}

extension CAGradientLayer {
    static func makeGradientLayer(
        frame: CGRect,
        colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
        endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = frame
        gradientLayer.colors = colors.map { $0.cgColor }

        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        return gradientLayer
    }
}
