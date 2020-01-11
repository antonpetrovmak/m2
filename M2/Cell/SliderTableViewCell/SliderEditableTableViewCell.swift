//
//  SliderEditableTableViewCell.swift
//  M2
//
//  Created by Petrov Anton on 1/2/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = Theme.clear
        placeholder = "0"
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

protocol SliderEditableTableViewCellDelegate {
    func rightValueDidChanged(_ sender: UITableViewCell, _ value: Float)
    func leftValueDidChanged(_ sender: UITableViewCell, _ value: Float)
}

class SliderEditableTableViewCell: UITableViewCell {
    // MARK: - @IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightTextField: CustomUITextField!
    @IBOutlet weak var slider: CustomSlider!
    
    weak var delegate: (SliderTableViewCellDelegate & SliderEditableTableViewCellDelegate)?
    private var viewModel: SliderTableViewCellViewModel?
    
    // MARK: - Public
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.BaseFamily.Medium(14).resize
        titleLabel.textColor = Theme.gray_A6AAB4
        rightTextField.delegate = self
        rightTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(onSliderChanged(_:_:)), for: .valueChanged)
    }
    
    func setViewModel(_ viewModel: SliderTableViewCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        slider.minimumValue = viewModel.minimumValue
        slider.maximumValue = viewModel.maximumValue
        slider.value = viewModel.value
        if let formatter = viewModel.rigthFormatter {
            rightTextField.isUserInteractionEnabled = formatter.editable
            rightTextField.font = formatter.font
            rightTextField.textColor = formatter.textColor
            rightTextField.keyboardType = formatter.keyboardType
            rightTextField.attributedPlaceholder = formatter.formatPlaceholder(from: viewModel.minimumValue)
        }
        if let leftFormatter = viewModel.leftFormatter {
            leftLabel.isUserInteractionEnabled = leftFormatter.editable
        }

        setRightLabel(by: viewModel.value)
        setLeftLabel(by: viewModel.value)
    }
    
    // MARK: - Private
    
    private func setRightLabel(by value: Float) {
        rightTextField.attributedText = viewModel?.rigthFormatter?.format(from: value)
    }
    
    private func setLeftLabel(by value: Float) {
        leftLabel.attributedText = viewModel?.leftFormatter?.format(from: value)
    }
    
    private func setRightEditableFormat(by value: Float?) {
        rightTextField.attributedText = viewModel?.rigthFormatter?.formateToEditable(from: value)
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

extension SliderEditableTableViewCell: UITextFieldDelegate {
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        if rightTextField == sender {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if rightTextField == textField {
            guard let text = textField.text,
                let viewModel = viewModel else { return }
            let processedText = text.isEmpty ? "\(viewModel.minimumValue)" : text
            guard let value = viewModel.rigthFormatter?.formateFromEditable(from: processedText) else { return }
            delegate?.rightValueDidChanged(self, value)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if rightTextField == textField {
            let value = viewModel?.value == viewModel?.minimumValue ? nil : viewModel?.value
            setRightEditableFormat(by: value)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if rightTextField == textField {
            guard let text = textField.text,
                let textRange = Range(range, in: text) else { return false }
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            return viewModel?.rigthFormatter?.isValidInputValue(updatedText) ?? false || updatedText.isEmpty
        }
        return false
    }
}
