//
//  Limitations.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

struct Limitations {
    struct Limit {
        let min: Double
        var max: Double
        var step: Double
        
        init(_ min: Double, _ max: Double, _ step: Double) {
            self.min = min
            self.max = max
            self.step = step
        }
        
        func around(value: Double) -> Double {
            return Swift.min(Swift.max(value, self.min), self.max)
        }
    }
    
    var apartmentArea          = Limit(1, 300, 1)
    var costOfOneQquareMeter   = Limit(100, 80_000, 100)
    var initialFee             = Limit(0, 1_000_000, 1000)
    var initialFeePercent      = Limit(0, 100, 1000)
    var creditPercent          = Limit(0, 0.5, 0.001)
    var creditTerm             = Limit(1, 120, 1)
}
