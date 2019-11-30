//
//  FormatterValueProtocol.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

protocol FormatterValueProtocol {
    func format(from value: Float) -> NSAttributedString?
}
