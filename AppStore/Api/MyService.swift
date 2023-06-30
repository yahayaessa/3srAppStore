//
//  MyService.swift
//  AppStore
//
//  Created by Yahaya on 27/06/2023.
//

import Foundation
import Moya
enum MyService {
    case login(email: String, password: String)
    case register(email: String,username:String,phone:String, password: String)
    case applications
    case getApplication(Int?)
    case showUser(id: Int)
    case showAccounts
}
extension MyService: TargetType {
    var baseURL: URL { URL(string: "https://3sr0store.com/api")! }
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
        case .applications:
            return "/users"
        case .showAccounts:
            return "/accounts"
        case .getApplication(_):
            return "/accounts"
        case .showUser(id: _):
            return "/accounts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showAccounts:
            return .get
        case .login,.register,.getApplication:
            return .post
        case .applications:
            return .post
        case .showUser(id: let id):
            return .post
        }
    }
    var task: Task {
        switch self {
        case  .showUser, .showAccounts: // Send no parameters
            return .requestPlain
//        case let .updateUser(_, firstName, lastName):  // Always sends parameters in URL, regardless of which HTTP method is used
//            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: URLEncoding.queryString)
//        case let .createUser(firstName, lastName): // Always send parameters as JSON in request body
//            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        case .login(email: let email, password: let password):
            return .requestPlain

        case .register(email: let email, username: let username, phone: let phone, password: let password):
            return .requestPlain

        case .applications:
            return .requestPlain

        case .getApplication(_):
            return .requestPlain

        }
    }
    var sampleData: Data {
        switch self {

        case .showUser(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
        case .register(email: let email, username: let username, phone: let phone, password: let password):
            return "{\"id\": 100, \"first_name\": \"\(email)\", \"last_name\": \"\(username)\"}".utf8Encoded
        case .login(email: let email, password: let password):
            return "{\"email\": \(email), \"password\": \"\(password)\"}".utf8Encoded
        case .showAccounts:
            // Provided you have a file named accounts.json in your bundle.
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .applications:
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getApplication(_):
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
