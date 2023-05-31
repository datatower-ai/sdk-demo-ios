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
//        DTAnalytics.trackEventName("track_sample_invalid", properties: properties2);
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
        //        DTAdReport.reportToShow("ad123", DTAd , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
        DTAdReport.report(toShow: "ad123",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          location: "home",
                          seq: seq,
                          properties: ["test":"testString","#test2":"testString2"],
                          entrance: "beat boss")
    }
    @IBAction func reportAdShow(_ sender: Any) {
//        DTAdReport.reportShow(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss"
//        )
        DTAdReport.reportShow("ad1234",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          location: "home",
                          seq: seq,
                          properties: ["test":"testString","#test2":"testString2"],
                          entrance: "beat boss")
    }
    @IBAction func reportAdClick(_ sender: Any) {
//        DTAdReport.reportClick(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
        DTAdReport.reportClick("ad1234",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          location: "home",
                          seq: seq,
                          properties: ["test":"testString","#test2":"testString2"],
                          entrance: "beat boss")
        
        DTAdReport.reportConversion(byClick: "12345",
                                           type: DTAdTypeRewarded,
                                           platform: DTAdPlatformAdmob,
                                           location: "home",
                                           seq: seq,
                                           properties: ["test":"testString","#test2":"testString2"],
                                           entrance: "beat boss"
        )
    }
    @IBAction func reportAdRewarded(_ sender: Any) {
//        DTAdReport.reportRewarded(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
        DTAdReport.reportRewarded("ad1234",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          location: "home",
                          seq: seq,
                          properties: ["test":"testString","#test2":"testString2"],
                          entrance: "beat boss")
        
        DTAdReport.reportConversion(byRewarded: "12345",
                                           type: DTAdTypeRewarded,
                                           platform: DTAdPlatformAdmob,
                                           location: "home",
                                           seq: seq,
                                           properties: ["test":"testString","#test2":"testString2"],
                                           entrance: "beat boss"
        )
    }
    @IBAction func reportAdPaid(_ sender: Any) {
        //独立广告平台（用的比较多）
        DTAdReport.reportPaid("ad1234",
                                    type: DTAdTypeRewarded,
                                    platform: DTAdPlatformAdmob,
                                    location: "home",
                                    seq: seq,
                                    value: "5001",
                                    currency: "01",
                                    precision: "1",
                                    properties: ["test":"testString","#test2":"testString2"],
                                    entrance: "main");
        
        //聚合广告平台（很少用）
        DTAdReport.reportPaid("ad1234",
                                    type: DTAdTypeRewarded,
                                    platform: DTAdPlatformAdmob,
                                    location: "home",
                                    seq: seq,
                              mediation:DTAdMediationCombo,
                            mediationId:"COMBO_23423",
                                    value: "5001",
                                    precision: "1",
                                    country: "usa",
                                    properties: ["test":"testString","#test2":"testString2"],
                                    entrance: "main");
        
    }
    @IBAction func reportReturnApp(_ sender: Any) {
        
        //现在不会由SDK维护，用户自行上报
        DTAdReport.reportReturnApp("ad123",
                                 type:DTAdTypeRewarded ,
                                 platform: DTAdPlatformAdmob,
                                 location: "home",
                                 clickGap: 12000,
                                 returnGap: 20000,
                                 seq: seq,
                                 properties: ["test":"testString","#test2":"testString2"],
                                 entrance: "main")
     
    }
  
    @IBAction func adShowFail(_ sender: Any) {
        DTAdReport.reportAdShowFail("12345",
                                    type: DTAdTypeRewarded,
                                    platform: DTAdPlatformAdmob,
                                    location:"home",
                                    seq: seq,
                                    errorCode: -1,
                                    errorMessage: "adShowFail",
                                    properties: ["test":"testString","#test2":"testString2"],
                                    entrance: "main"
        )
    }
    @IBAction func adLoadEnd(_ sender: Any) {
        DTAdReport.reportLoadEnd("12345",
                                 type: DTAdTypeRewarded,
                                 platform: DTAdPlatformAdmob,
                                 duration: 30,
                                 result: true,
                                 seq: seq,
                                 errorCode: 0,
                                 errorMessage: "test ad load end",
                                 properties: ["test":"testString","#test2":"testString2"]
        )
    }
    @IBAction func adLoadBegin(_ sender: Any) {
        DTAdReport.reportLoadBegin( "12345",
                                    type:DTAdTypeRewarded,
                                    platform: DTAdPlatformAdmob,
                                    seq: seq,
                                    properties: ["test":"testString","#test2":"testString2"])
    }
    @IBAction func reportAdClose(_ sender: Any) {
//        DTAdReport.reportClose(id: "ad123", type:AdType.REWARDED , platform: AdPlatform.ADMOB, location: "home", seq: seq,entrance: "beat boss")
        DTAdReport.reportClose("ad1234",
                          type: DTAdTypeRewarded,
                          platform: DTAdPlatformAdmob,
                          location: "home",
                          seq: seq,
                          properties: ["test":"testString","#test2":"testString2"],
                          entrance: "beat boss")

    }

    
    @IBAction func reportLeftApp(_ sender: Any) {
        DTAdReport.reportLeftApp("ad123",
                                 type:DTAdTypeRewarded ,
                                 platform: DTAdPlatformAdmob,
                                 location: "home",
                                 seq: seq,
                                 properties: ["test":"testString","#test2":"testString2"],
                                 entrance: "main"
        )
        
    
        DTAdReport.reportConversion(byLeftApp: "12345",
                                           type: DTAdTypeRewarded,
                                           platform: DTAdPlatformAdmob,
                                           location: "home",
                                           seq: seq,
                                           properties: ["test":"testString","#test2":"testString2"],
                                           entrance: "beat boss"
        )
        
    }
    
    @IBAction func reportIapEntrance(_ sender: Any) {
        DTIAPReport.reportEntrance("3421",
                                   sku: "sku_001",
                                   price: 3.32,
                                   currency: "USD",
                                   seq: seq,
                                   placement:iap_placement)
    }
    
    @IBAction func reportIapToPurchase(_ sender: Any) {
        DTIAPReport.report(toPurchase: "3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq,placement:iap_placement)
    }
    
    
    @IBAction func reportIapPurchased(_ sender: Any) {
        DTIAPReport.reportPurchased("3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq,placement:iap_placement)
    }
    
    @IBAction func reportIapNotPurchase(_ sender: Any) {
        DTIAPReport.reportNot(toPurchased: "3421", sku: "sku_001", price: 3.32, currency: "USD", seq: seq,code: "01",msg: "no menony",placement:iap_placement)
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


