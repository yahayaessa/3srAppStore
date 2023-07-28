//
//  APIError.swift
//  tweetly
//
//  Created by Hussein Work on 21/05/2021.
//

import Foundation

struct APIError: LocalizedError {
    let message: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case message
        case code = "code"
    }
    
    init(message: String){
        self.message = message
        self.code = 400
    }
    
    init(message: String, statusCode: Int){
        self.message = message
        self.code = statusCode
    }
    
    var errorDescription: String? {
        message
    }
}

extension APIError: Codable { }
