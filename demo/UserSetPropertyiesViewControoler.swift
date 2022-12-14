//
//  UserSetPropertyiesViewControoler.swift
//  AnalyticsDemo
//
//  Created by Apple06 on 2022/7/12.
//
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
}
