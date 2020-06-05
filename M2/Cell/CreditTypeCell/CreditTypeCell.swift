//
//  CreditTypeCell.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

struct CreditTypeCellViewModel {
    let selectedIndex: Int
    let segments: [String]
}

protocol CreditTypeCellDelegate: class {
    func segmentedControlValueChanged(_ index: Int)
}

class CreditTypeCell: UITableViewCell {

    @IBOutlet weak var segmentControl: CustomSegmentedControl! {
        didSet {
            segmentControl.backgroundColor = Theme.white
            segmentControl.normanTextAttributes = [.foregroundColor: Theme.gray_757F8C,
                                                   .font: UIFont.BaseFamily.Medium(14).resize]
            segmentControl.selectedTextAttributes = [.foregroundColor: Theme.white,
                                                   .font: UIFont.BaseFamily.Medium(14).resize]
            segmentControl.highlightedTextAttributes = [.foregroundColor: Theme.white,
                                                   .font: UIFont.BaseFamily.Medium(14).resize]
            segmentControl.delegate = self
            segmentControl.layer.masksToBounds = true
            segmentControl.layer.cornerRadius = 6
        }
    }

    weak var delegate: CreditTypeCellDelegate?

    func setViewModel(_ viewModel: CreditTypeCellViewModel) {
        segmentControl.setButtonTitles(buttonTitles: viewModel.segments)
        segmentControl.setIndex(index: viewModel.selectedIndex)
    }

}

// MARK: CustomSegmentedControlDelegate

extension CreditTypeCell: CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        delegate?.segmentedControlValueChanged(index)
    }
}
