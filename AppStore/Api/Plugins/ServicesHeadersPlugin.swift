//
//  ServicesHeadersPlugin.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Moya
import Resolver
import RxRelay
struct ServicesHeadersPlugin: PluginType {
    
    @Injected var authenticationManager: AuthenticationManagerType
        
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {

        var request = request
        var defaultHeaders: [String: String] = [
            "Accepts": "application/json",
        ]
                
        if let language = Bundle.main.preferredLocalizations.first {
            defaultHeaders["Language"] = language
        }

        defaultHeaders["App-Version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        
        if let token = authenticationManager.authorizationToken {
            defaultHeaders["Authorization"] = token
        }
        
        defaultHeaders.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return request
    }
}
protocol AuthenticationManagerType {
    
    var authenticationState: BehaviorRelay<AuthState> { get }
    var profile: BehaviorRelay<User?> { get }
    
    var isAuthenticated: Bool { get }
    var authorizationToken: String? { get }
    var username: String? { get }
    var userID: Int? { get }
    
    
    func logout()
    func login(with response: User)
    func update(profile: User)
}
enum AuthState {
    case authenticated(User)
    case unauthenticated
    
    var isAuthenticated: Bool {
        if case .authenticated = self {
            return true
        }
        
        return false
    }
    
    var authInfo: User? {
        if case .authenticated(let value) = self {
            return value
        }
        
        return nil
    }
}
