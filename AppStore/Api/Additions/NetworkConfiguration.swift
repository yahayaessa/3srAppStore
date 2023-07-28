//
//  NetworkConfiguration.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import Moya
import Resolver

/**
 Aka. Server configuration.
 This provides us with the url for the current using server, eg. development, qc, or live.
 */
enum NetworkConfiguration: String {
    case base
    
    static var current: NetworkConfiguration {
        .base
    }
    
    var baseURL: URL {
        switch self {
        case .base:
            // target base url: freely.ws
            return URL(string: "https://freely.ws/mobile_api/")!
        }
    }
}


extension TargetType {
    var sessionToken: String {
        Resolver.resolve(AuthenticationManagerType.self).authorizationToken ?? ""
    }
    
    var username: String {
        Resolver.resolve(AuthenticationManagerType.self).username ?? ""
    }
    
    var userID: Int {
        Resolver.resolve(AuthenticationManagerType.self).userID ?? -1
    }
}
