//
//  CreditTypeViewModelFactory.swift
//  M2
//
//  Created by Petrov Anton on 11/30/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit

struct CreditTypeViewModelFactory {
    func makeCreditTypeCellViewModel(_ selectedIndex: Int) -> CreditTypeCellViewModel {
        return CreditTypeCellViewModel(selectedIndex: selectedIndex,
                                       segments: [CreditType.standard.localizedString,
                                                  CreditType.annuity.localizedString])
    }
}
