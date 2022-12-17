//
//  AppDelegate.swift
//  AnalyticsDemo
//
//  Created by Apple02 on 2021/2/25.
//

import UIKit
import DTSDK


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appid = "dt_461a208fdd075c27"
        let serverUrl = "https://report-inner.roiquery.com"
//        let serverUrl = "https://test.roiquery.com"
//        let serverUrl = "https://report.roiquery.com"
        let channel :DTChannel = DTChannelAppStore
        let logLevel :DTLoggingLevel = DTLoggingLevelDebug;
        DT.initSDK(appid ,serverUrl: serverUrl, channel: channel, isDebug: true, logLevel: logLevel)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

