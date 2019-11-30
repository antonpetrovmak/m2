//
//  NSObjectExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/29/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: Self.self)
    }
}
