//
//  StringExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/20/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func firstCharacterUpperCase() -> String {
        let lowercaseString = self.lowercased()
        let firstCharacter = String(lowercaseString[lowercaseString.startIndex]).uppercased()
        return lowercaseString
            .replacingCharacters(in: lowercaseString.startIndex...lowercaseString.startIndex,
                                 with: firstCharacter)

    }
}
