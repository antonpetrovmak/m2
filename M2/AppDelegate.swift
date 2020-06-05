//
//  AppDelegate.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit
import Firebase
import Fabric
import Crashlytics
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = Config.mobileAdsTestDeviceIdentifiers
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    AppEvents.activateApp()
  }

}

