//
//  AppDelegate.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import PureLayout
import RealmSwift
import UserNotifications

struct Device {
    static var deviceToken: String = ""
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var vkDelegateReference: SwiftyVKDelegate?
    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        defaults.set("none", forKey: "userId")
        vkDelegateReference = VKDelegate()
        SwiftReachability.sharedManager?.startMonitoring()
        UINavigationBar.appearance().tintColor = .toasterBlue
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 17)!], for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.toasterBlue, NSAttributedString.Key.font: UIFont(name: "Lato-Regular", size: 17)!], for: .normal)
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let config = Realm.Configuration(schemaVersion: 1 ,migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        VK.handle(url: url, sourceApplication: app)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VK.handle(url: url, sourceApplication: sourceApplication)
        return true
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
extension AppDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("You are offline")
        (vkDelegateReference as! VKDelegate).markOffline
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("You are online")
        (vkDelegateReference as! VKDelegate).markOnline
    }
}
