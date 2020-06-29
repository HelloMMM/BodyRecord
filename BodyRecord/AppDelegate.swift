//
//  AppDelegate.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

var isRemoveAD: Bool = false
var appStyle = 0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let style = UserDefaults.standard.object(forKey: "appStyle") {
            
            appStyle = style as! Int
        }
        
        if let removeAD = UserDefaults.standard.object(forKey: "isRemoveAD") {
            
            isRemoveAD = removeAD as! Bool
        }
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }
}

