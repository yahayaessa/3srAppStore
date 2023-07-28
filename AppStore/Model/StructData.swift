//
//  StrctData.swift
//  AppStore
//
//  Created by Yahaya on 03/07/2023.
//

import Foundation
struct StructData<T>:ResponseContainerType{
    var links: [String:Any]
    var meta: [String:Any]
    
    var id: Int
    var data:[T]
    var icon:String
    // function parse json data
    enum CodingKeys: String, CodingKey {
        case data
        case meta
        case links = "message"
    }
}
extension StructData: Decodable where T: Decodable { }
extension StructData: Encodable where T: Encodable { }
