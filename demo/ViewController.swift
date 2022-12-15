//
//  ViewController.swift
//  AnalyticsDemo
//
//  Created by Apple02 on 2021/2/25.
//

import UIKit
import DTSDK
import StoreKit

class ViewController: UIViewController {
    
    var eventName = "sample_event"
    
    var seq = ""
    
    var iap_placement = "test_iap_placement"
    
    var properties:[String:Any] = ["#testForproperties":"test"] 
    
    let errorCode:Int = 23
    let erromsg : String = "test for errormsg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        seq = AdUtils.generateUUID()
//        DTAnalytics.setFirebaseAppInstanceID(fiid: "12345dsf")
//        DTAnalytics.setAppsFlyerID(afuid: "afuid")
//        DTAnalytics.setIasOriginalOrderID(orderId: "order123456")
//        DT.enableThirdShare(type: DTShareType.APPSFlYER)
////        DTAnalytics.setFCMToken(token: "fcm_token_test_1287")
//
//        DTAnalytics.userSet(properties: properties)
//        let key1=""
//        let key2="testForproperties"
//        DTAnalytics.userUnset(_properties: key1,key2)
        
//        DTAnalytics.getServerTime(getServerTimeFinish: serverTime)
        
        
            
        // Do any additional setup after loading the view.
//        ROIQueryAnalytics.track(eventName: "app_open", properties: ["tast":"23"])
//        ROIQueryAnalytics.setAccountId(accountId: "734506")
//        ROIQueryAnalytics.track(eventName: "test2", properties: ["tast2":"234"])
    }
    @IBAction func trackEvent(_ sender: Any) {
//        [DTAnalytics trackEventName @"track_sample" properties: @{@"p":"1"}];
        let properties1 = ["product_name": "商品名"] as [String: Any]
        let properties2 = ["#product_name": "商品名"] as [String: Any]
        DTAnalytics.trackEventName("track_sample", properties: properties1);
        DTAnalytics.trackEventName("track_sample_invalid", properties: properties2);
        
    }
    
    func serverTime(time:Int64,msg:String){
        print("90-9-0---"+time.description)
    }
    
    @IBAction func TimerStart(_ sender: Any) {
        DTAnalyticsUtils.trackTimerStart(eventName)
    }
    @IBAction func TimerPause(_ sender: Any) {
        DTAnalyticsUtils.trackTimerPause(eventName)
    }
    @IBAction func resumTimer(_ sender: Any) {
        DTAnalyticsUtils.trackTimerResume(eventName)
    }
    @IBAction func TimerEnd(_ sender: Any) {
        DTAnalyticsUtils.trackTimerEnd(eventName)
    }
    
    
    
    /// ad
    @IBAction func reportAdEntrance(_ sender: Any) {
        
    }
    @IBAction func reportAdToShow(_ sender: Any) {
//        DTAdReport.reportToShow(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
    }
    @IBAction func reportAdShow(_ sender: Any) {
//        DTAdReport.reportShow(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss"
//        )
    }
    @IBAction func reportAdClick(_ sender: Any) {
//        DTAdReport.reportClick(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
    }
    @IBAction func reportAdRewarded(_ sender: Any) {
//        DTAdReport.reportRewarded(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
    }
    @IBAction func reportAdPaid(_ sender: Any) {
//        DTAdReport.reportPaid(id: "",
//                                    type: AdType.BANNER,
//                                    platform: AdPlatform.MOPUB,
//                                    location: "home",
//                                    seq: seq,
//                                    value: "5001",
//                                    currency: "01",
//                                    precision: "1",
//                                    entrance: "main");
    }
    @IBAction func reportAdImpression(_ sender: Any) {
//        DTAdReport.reportPaid(
//            id: "12435",
//            type: AdType.REWARDED,
//            platform: "unity", adgroupType: "",
//            location: "home",
//            seq: seq,
//            mediation: AdMediation.MOPUB,
//            mediationId: "32432545",
//            value: "5000",
//            currency: "usd",
//            precision: "sdf",
//            country: "USA",
//            entrance: "hone"
//                            )
    }
  
    @IBAction func adShowFail(_ sender: Any) {
        //DTAdReport.reportAdShowFail(id: "12345", type: AdType.APP_OPEN, platform: AdPlatform.ADX, location:
//                                        "home", seq: seq, errorCode: 1, errorMessage: "adShowFail")
    }
    @IBAction func adLoadEnd(_ sender: Any) {
//        DTAdReport.reportLoadEnd(id: "12345", type: AdType.APP_OPEN, platform: AdPlatform.ADX, duration: Int64(30), result: true, seq: seq, errorCode: 0, errorMessage: "test ad load end")
    }
    @IBAction func adLoadBegin(_ sender: Any) {
//        DTAdReport.reportLoadBegin(id: "12345", type:AdType.APP_OPEN, platform: AdPlatform.ADCOLONY, seq: seq)
    }
    @IBAction func reportAdClose(_ sender: Any) {
//        DTAdReport.reportClose(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")

    }
    @IBAction func reportAdConversion(_ sender: Any) {
//        DTAdReport.reportConversionByClick(id: "12345", type: AdType.APP_OPEN, platform: AdPlatform.ADCOLONY, location: "MainController", seq: seq)
    }
    
    @IBAction func reportLeftApp(_ sender: Any) {
//        let url:URL?=URL.init(string: "https://www.baidu.com/")
//        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
//        DTAdReport.reportLeftApp(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
    }
    
    @IBAction func reportIapEntrance(_ sender: Any) {
//        DTIAPReport.reportEntrance(order: "3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq,placement:iap_placement)
    }
    
    @IBAction func reportIapToPurchase(_ sender: Any) {
//        DTIAPReport.reportToPurchase(order: "3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq)
    }
    
    
    @IBAction func reportIapPurchased(_ sender: Any) {
//        DTIAPReport.reportPurchased(order: "3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq)
    }
    
    @IBAction func reportIapNotPurchase(_ sender: Any) {
//        DTIAPReport.reportNotToPurchased(order: "3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq,code: "01",msg: "no menony")
    }
   
    @IBAction func setAccountId(_ sender: Any) {
        let accountId = "12138"
        DTAnalytics.setAccountId(accountId)
    }
    @IBAction func setFirebaseId(_ sender: Any) {
        let firebaseId = "firebase_12138"
        DTAnalytics.setFirebaseAppInstanceId(firebaseId)
    }
    @IBAction func setAppFlyerId(_ sender: Any) {
        let appFlyerId = "appflyer_12138"
        DTAnalytics.setAppsFlyerId(appFlyerId)
    }
    @IBAction func setAdjustId(_ sender: Any) {
        let adjustId = "adjustId_12138"
        DTAnalytics.setAdjustId(adjustId)
    }
    @IBAction func setFcmToken(_ sender: Any) {
//        let fcmToken = "fcmToken_12138"
        
    }
    @IBAction func setKochavId(_ sender: Any) {
        let kochavId = "kochavId_12138"
        DTAnalytics.setKochavaId(kochavId)
    }
}


