import UIKit
import DataTowerAICore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appid = "dt_0e3fa14f6d26b302"
//        let serverUrl = "https://report-inner.roiquery.com"
        let serverUrl = "http://34.148.97.101"
//        let serverUrl = "https://report.roiquery.com"
        let channel :DTChannel = DTChannelAppStore
        let logLevel :DTLoggingLevel = DTLoggingLevelDebug;
        DT.initSDK(appid ,serverUrl: serverUrl, channel: channel, isDebug: true, logLevel: logLevel, enableTrack: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            DTAnalytics.setSuperProperties(["commonProper_Str":"1",
//                                            "commonProper_int":2,])
//            DTAnalytics.setDynamicSuperProperties {
//                return ["dynamicProper_Str":"3",
//                        "dynamicProper_int":4];
//            }
            
            DTAnalytics.setEnableTracking(true)
        })
       
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

