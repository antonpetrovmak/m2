//
//  CustomSegmentedControl.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//


import UIKit
protocol CustomSegmentedControlDelegate:class {
    func changeToIndex(index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles:[String]!
    private(set) var buttons: [UIButton] = [UIButton]()
    private(set) var selectorView: UIView?
    
    var selectorViewColor: UIColor = .gray
    var selectedTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white,
                                                                  .backgroundColor: UIColor.clear]
    var normanTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.black,
                                                                .backgroundColor: UIColor.clear]
    var highlightedTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white,
                                                                     .backgroundColor: UIColor.clear]
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    private(set) var selectedIndex : Int = 0
    
    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
        backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons[selectedIndex].isSelected = false
        let button = buttons[index]
        selectedIndex = index
        button.isSelected = true
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        selectorView?.frame.origin.x = selectorPosition
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.isSelected = false
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.changeToIndex(index: selectedIndex)
                selectorView?.frame.origin.x = selectorPosition
                btn.isSelected = true
            }
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        configSelectorView()
        createButton()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        selectorView?.removeFromSuperview()
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        let _selectorViewFrame = CGRect(x: 0, y: 0, width: selectorWidth, height: bounds.size.height)
        let _selectorView = UIView(frame: _selectorViewFrame)
        _selectorView.backgroundColor = selectorViewColor
        _selectorView.layer.masksToBounds = true
        _selectorView.layer.cornerRadius = 6
        
        let gradient = CAGradientLayer.makeGradientLayer(frame: _selectorViewFrame,
                                                         colors: [Theme.purple_8676FB, Theme.purple_AB7BFF])
        gradient.cornerRadius = 6
        _selectorView.layer.addSublayer(gradient)
        addSubview(_selectorView)
        selectorView = _selectorView
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        buttons.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .custom)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setAttributedTitle(NSAttributedString(string: buttonTitle,
                                                         attributes: normanTextAttributes), for: .normal)
            button.setAttributedTitle(NSAttributedString(string: buttonTitle,
                                                         attributes: selectedTextAttributes), for: .selected)
            button.setAttributedTitle(NSAttributedString(string: buttonTitle,
                                                         attributes: highlightedTextAttributes), for: .highlighted)
            button.tintColor = .clear
            buttons.append(button)
        }
        buttons[selectedIndex].isSelected = true
    }
}
