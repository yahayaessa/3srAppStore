//
//  User.swift
//  AppStore
//
//  Created by Yahaya on 26/06/2023.
//

import Foundation
struct User:Codable,Identifiable{

    var id:Int
    var can_deleted:Int?
    var name:String
    var email:String
    var phone_number:String
    var device_udid:String?
    var created_at:String?
    var updated_at:String?
    var token:String? = ""
    
    
}
struct UserProfileCache {
    static let key = "userProfileCache"
    static func save(_ value: User!) {
        var user = value
        if user?.token == nil{
            user?.token = UserProfileCache.get()!.token
        }
         UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: key)
    }
    static func get() -> User? {
        var userData: User?
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(User.self, from: data)
            return userData
        } else {
            return nil
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
struct AppTokenCache {
    static let key = "appTokenCache"
    static func save(_ value: String!) {
         UserDefaults.standard.set(value, forKey: key)
    }
    static func get() -> String? {
        if let data = UserDefaults.standard.string(forKey: key) {
            return data
        } else {
            return nil
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
