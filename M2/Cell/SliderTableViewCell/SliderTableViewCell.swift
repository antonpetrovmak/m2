//
//  SliderTableViewCell.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

protocol SliderTableViewCellDelegate: class {
    func sliderDidChange(_ sender: UITableViewCell, _ value: Float)
    func sliderDidStopped(_ sender: UITableViewCell, _ value: Float)
}

class SliderTableViewCell: UITableViewCell {

    // MARK: - @IBOutlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var slider: CustomSlider!

    weak var delegate: SliderTableViewCellDelegate?
    private var viewModel: SliderTableViewCellViewModel?

    // MARK: - Public

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.BaseFamily.Medium(14).resize
        titleLabel.textColor = Theme.gray_A6AAB4
        slider.addTarget(self, action: #selector(onSliderChanged(_:_:)), for: .valueChanged)
    }

    func setViewModel(_ viewModel: SliderTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        slider.minimumValue = viewModel.minimumValue
        slider.maximumValue = viewModel.maximumValue
        slider.value = viewModel.value
        rigthFormatter = viewModel.rigthFormatter
        leftFormatter = viewModel.leftFormatter
        setRightLabel(by: viewModel.value)
        setLeftLabel(by: viewModel.value)
        self.viewModel = viewModel
    }

    // MARK: - Private

    private var rigthFormatter: FormatterValueProtocol?
    private var leftFormatter: FormatterValueProtocol?

    private func setRightLabel(by value: Float) {
        rightLabel.attributedText = rigthFormatter?.format(from: value)
    }

    private func setLeftLabel(by value: Float) {
        leftLabel.attributedText = leftFormatter?.format(from: value)
    }

    // MARK: - Actions

    @objc func onSliderChanged(_ sender: UISlider, _ event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .moved:
                let value = roundValueByStep(sender.value)
                setRightLabel(by: value)
                setLeftLabel(by: value)
                delegate?.sliderDidChange(self, value)
            case .ended:
                let value = roundValueByStep(sender.value)
                setRightLabel(by: value)
                setLeftLabel(by: value)
                delegate?.sliderDidStopped(self, value)
            default:
                break
            }
        }
    }

    private func roundValueByStep(_ value: Float) -> Float {
        guard let step = viewModel?.step else { return value }
        return round(value / step) * step
    }

}
