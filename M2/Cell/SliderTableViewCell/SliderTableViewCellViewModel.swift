//
//  SliderTableViewCellViewModel.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

struct SliderTableViewCellViewModel {
    var minimumValue: Float
    var maximumValue: Float
    var value: Float
    var title: String
    var rigthFormatter: FormatterValueProtocol?
    var leftFormatter: FormatterValueProtocol?
}
