//
//  AppDelegate.swift
//  M2
//
//  Created by Petrov Anton on 11/17/19.
//  Copyright © 2019 APM. All rights reserved.
//

import UIKit
import FirebaseCore
import Fabric
import Crashlytics
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    FirebaseApp.configure()
    //GADMobileAds.sharedInstance() .start(completionHandler: nil)
    //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["6949d47404c6cd88aef1e83a1a1c241f"]
    //Crashlytics.sharedInstance().crash()
    FirebaseManager.share.feachResidentialComplex()
    FirebaseManager.share.fetchCredits()
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    AppEvents.activateApp()
  }

}

