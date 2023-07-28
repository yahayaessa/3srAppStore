//
//  ResponseContainerType.swift
//  tweetly
//
//  Created by Hussein AlRyalat on 12/05/2021.
//

import Foundation

protocol ResponseContainerType {
    var message: String { get }
    var errors:[String:Any]? { get }
//    var code: Int { get }
}
