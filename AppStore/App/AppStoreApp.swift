//
//  AppStoreApp.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI
//import FirebaseRemoteConfig

@main
struct AppStoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            if UserProfileCache.get() != nil{
                TabBarView(selected: .home).environment(\.layoutDirection, .rightToLeft).environmentObject(HomeViewModel()).environmentObject(ApplicationsViewModel()).environmentObject(CategoryViewModel()).environmentObject(AuthViewModel())
            }else{
                NavigationStack {
                    SplashScreen().environment(\.layoutDirection, .rightToLeft)
                }
            }
        }
    }
}

let appFont = "Questv1-Regular"
func goToMainView(){
    let window = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
    if UserProfileCache.get() != nil{
        window?.rootViewController = UIHostingController(rootView: TabBarView(selected: .home).environmentObject(HomeViewModel()).environmentObject(CategoryViewModel()).environmentObject(ApplicationsViewModel()).environmentObject(AuthViewModel()).environment(\.layoutDirection, .rightToLeft))
        window?.makeKeyAndVisible()
    }else{
        window?.rootViewController = UIHostingController(rootView:NavigationStack {
            SplashScreen().environment(\.layoutDirection, .rightToLeft)

        })
        window?.makeKeyAndVisible()
        
    }

}

func skip(){
    let window = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
        window?.rootViewController = UIHostingController(rootView: TabBarView(selected: .home).environmentObject(HomeViewModel()).environmentObject(CategoryViewModel()).environmentObject(ApplicationsViewModel()).environmentObject(AuthViewModel()).environment(\.layoutDirection, .rightToLeft))
        window?.makeKeyAndVisible()
    

}
