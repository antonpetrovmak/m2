//
//  Config.swift
//  M2
//
//  Created by Petrov Anton on 05.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

final class Config {

    private init() { }

    #if DEBUG
    static let BannerADUnitID = "ca-app-pub-3940256099942544/2934735716"
    #else
    static let BannerADUnitID = "ca-app-pub-1930298360199276/5093504222"
    #endif

    static let mobileAdsTestDeviceIdentifiers = ["6949d47404c6cd88aef1e83a1a1c241f"]

}
