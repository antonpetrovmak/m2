//
//  CustomSlider.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 2
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews[0].layer.cornerRadius = trackHeight / 2
        subviews[1].layer.cornerRadius = trackHeight / 2
    }
}
