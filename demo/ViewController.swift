import UIKit
import DataTowerAICore
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
        print("DataTowerId:",DTAnalytics.getDataTowerId())
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
    @IBAction func reportAdShow(_ sender: Any) {
        DTAdReport.reportShow("ad1234",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          properties: ["test":"testString","#test2":"testString2"]
                          )
    }
    
    @IBAction func reportConversion(_ sender: Any) {
        DTAdReport.reportConversion("ad1234",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          properties: ["test":"testString","#test2":"testString2"]
                          )
    }
    
    
    @IBAction func purchaseSuccess(_ sender: Any) {
        DTIAPReport.reportPurchaseSuccess("order_12343", sku: "sku_34jfksd", price: 9.8, currency: "usd", properties: ["test":"testString","#test2":"testString2"])
    }
    @IBAction func subscribeSuccess(_ sender: Any) {
        
        DTIASReport.reportSubscribeSuccess("ooid_sidjf", orderId: "order_12343", sku: "sku_34jfksdsd", price: 8.7, currency: "usd", properties: ["test":"testString","#test2":"testString2"])
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
    @IBAction func setIasOriginalOrderId(_ sender: Any) {
        let iasOriginalOrderId = "IasOriginalOrderId_12138"
        DTAnalytics.setIasOriginalOrderId(iasOriginalOrderId)
    }
    @IBAction func setKochavId(_ sender: Any) {
        let kochavId = "kochavId_12138"
        DTAnalytics.setKochavaId(kochavId)
    }
}


