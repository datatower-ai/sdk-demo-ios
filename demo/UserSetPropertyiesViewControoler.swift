import UIKit
import Foundation
import StoreKit
import DTSDK

class UserSetPropertiesViewConTroller: UIViewController {
    
  
    @IBOutlet weak var useHintShow: UITextView!
    var changeAge = true
    var userSetProperties:[String:Any] = [:]
    
    override func viewDidLoad() {
        showProperties(properties: userSetProperties)
        
    }
    
    
    
    @IBAction func userSet(_ sender: Any) {
        changeAge = !changeAge
        userSetProperties = [:]
        if changeAge {
            userSetProperties ["user_age"] = 23
        }else{
            userSetProperties ["user_age"] = 26
        }
        let course = ["语文","math","biology"]
        userSetProperties ["user_password"] = "7897070"
        userSetProperties["total_login_times"] = 1
        userSetProperties["course"] = course

        DTAnalytics.userSet(userSetProperties)

        showProperties(properties: userSetProperties)
    }
    
    @IBAction func userSetOnce(_ sender: Any) {
        var userSetOnceProperties:[String:Any] = [:]
        userSetOnceProperties["user_first_login_time"] = "2022-10-28"
        DTAnalytics.userSetOnce(userSetOnceProperties)
        showProperties(properties: userSetOnceProperties)
    }
    
    var timeOfLogin = 1
    @IBAction func userAdd(_ sender: Any) {
        var userAddProperties:[String:Any] = [:]
        timeOfLogin=timeOfLogin+1
        userAddProperties["total_login_times"] = timeOfLogin
        DTAnalytics.userAdd(userAddProperties)
        showProperties(properties: userAddProperties)
    }
    
    
    @IBAction func userUnset(_ sender: Any) {
        DTAnalytics.userUnset("user_password")
        showProperties(text: "user_password")
    }
    
    
    @IBAction func userDelete(_ sender: Any) {
        DTAnalytics.userDelete()
        showProperties(text: "---userDelete----")
    }
    
    
    @IBAction func userAppend(_ sender: Any) {
        let course = ["History"]
        let userAppendProperties = ["course":course]
        DTAnalytics.userAppend(userAppendProperties)
        showProperties(properties: userAppendProperties)
        
    }
    
    func showProperties(properties:[String:Any])  {
        useHintShow.text = properties.description
    }
    func showProperties(text:String)  {
        useHintShow.text = text
    }
    
    @IBAction func iasToshow(_ sender: Any) {
        DTIASReport.report(toShow: "order_1234", entrance: "home", placement: "vip", properties: [:])
    }
    @IBAction func iasShowSuccess(_ sender: Any) {
        DTIASReport.reportShowSuccess("order_1234", entrance: "home", placement: "vip", properties: [:])
    }
    
    @IBAction func iasShowFail(_ sender: Any) {
        DTIASReport.reportShowFail("order_1234", entrance: "home", placement: "vip", errorCode: "-1", errorMsg: "cancel", properties: [:])
    }
    
    @IBAction func iasSubscribe(_ sender: Any) {
        DTIASReport.reportSubscribe("order_1234",
                                    entrance: "home",
                                    placement: "vip",
                                    sku: "sku_234234",
                                    orderId: "order_sdfsd",
                                    price: "34.5",
                                    currency: "usd",
                                    properties: [:])
    }
    
    
    @IBAction func iasSubscribeSuccess(_ sender: Any) {
        DTIASReport.reportSubscribeSuccess("order_1234",
                                    entrance: "home",
                                    placement: "vip",
                                    sku: "sku_234234",
                                    orderId: "order_sdfsd",
                                    originalOrderId:"originalOrderId_sdfsd",
                                    price: "34.5",
                                    currency: "usd",
                                    properties: [:])
    }
    
    @IBAction func reportSubscribeFail(_ sender: Any) {
        DTIASReport.reportSubscribeFail("order_1234",
                                    entrance: "home",
                                    placement: "vip",
                                    sku: "sku_234234",
                                    orderId: "order_sdfsd",
                                    originalOrderId:"originalOrderId_sdfsd",
                                    price: "34.5",
                                    currency: "usd",
                                        errorCode: "-9",
                                        errorMsg: "no meney",
                                    properties: [:])
    }
    
    
}
