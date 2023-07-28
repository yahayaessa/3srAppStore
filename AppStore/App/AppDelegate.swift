//
//  AppDelegate.swift
//  AngelaCard
//
//  Created by Angela Yu on 06/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
//import OneSignal
import SwiftUI
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
             
        FirebaseApp.configure()
//          Override point for customization after application launch.
//
//          Remove this method to stop OneSignal Debugging
//          OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
//
//          // OneSignal initialization
//          OneSignal.initWithLaunchOptions(launchOptions)
//          OneSignal.setAppId("e91ef4ce-295b-49b7-871b-af1a8b2d5ad6")
//
//          // promptForPushNotifications will show the native iOS notification permission prompt.
//          // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
//          OneSignal.promptForPushNotifications(userResponse: { accepted in
//            print("User accepted notifications: \(accepted)")
//          })
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.accentColor)
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)

           UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        return true
    }
    func checkLogin()  {

        if UserProfileCache.get() != nil {
            let contentView =  NavigationStack {
                SplashScreen().environment(\.layoutDirection, .rightToLeft)

//                LoginScreen().environment(\.layoutDirection, .rightToLeft).environmentObject(AuthViewModel())
            }
                window?.rootViewController = UIHostingController(rootView: contentView)
                window?.makeKeyAndVisible()
        } else {
            let contentView = TabBarView(selected: .home).environmentObject(HomeViewModel()).environmentObject(CategoryViewModel()).environment(\.layoutDirection, .rightToLeft)
                window?.rootViewController = UIHostingController(rootView: contentView)
                window?.makeKeyAndVisible()
        }
 
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

