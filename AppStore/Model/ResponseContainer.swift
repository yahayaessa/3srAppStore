//
//  ResponseContainer.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct ResponseContainer<C>: ResponseContainerType {
    var errors: [String : Any]?

    let data: C?
    let _message: String?
//    let code: Int

    var message: String {
        _message ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case data
//        case code
        case _message = "message"
    }
}

extension ResponseContainer: Decodable where C: Decodable { }
extension ResponseContainer: Encodable where C: Encodable { }
