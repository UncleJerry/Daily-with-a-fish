//
//  AppDelegate.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/1/24.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import UserNotifications
import Alamofire
import RealmSwift

let realm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        application.registerForRemoteNotifications()

        /*
        let profile = Profile()
        profile.dateString = "2017-01-23"
        profile.Firstname = "Jerry"
        profile.Lastname = "Chou"
        
        profile.isFemale = false
        
        try! realm.write {
            realm.add(profile)
        }*/
        
        let defaults: UserDefaults = UserDefaults.standard
    
        if !defaults.bool(forKey: "LaunchedBefore") {
            defaults.set(true, forKey: "LaunchedBefore")
            defaults.set(true, forKey: "DisplayTotalDays")
        }
        
        
        // Override point for customization after application launch.
        return true
    }
    
    // Notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        let status = realm.objects(Status.self)
        if status.count == 0 {
            
            let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            let newstatus = Status()
            newstatus.deviceid = deviceTokenString
            
            try! realm.write {
                realm.add(newstatus)
            }
        }
        
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

