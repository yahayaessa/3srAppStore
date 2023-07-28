//
//  MyService.swift
//  AppStore
//
//  Created by Yahaya on 27/06/2023.
//

import Foundation
import Moya
import Promises
 let provider = MoyaProvider<MyService>(endpointClosure: { (target: MyService) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    switch target {
    default:
        let httpHeaderFields = ["Accept" : "application/json"]
        return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
    }
})

enum MyService {
    case login(email: String, password: String)
    case loginPhone(number: String, code: String?)
    case loginUDID(String)
    case register(email: String,username:String,phone:String, password: String,password_confirmation:String)
    case applications(Int)
    case getPlistApp(String)
    case categories
    case products(id: Int)
    case searchProducts(q: String)
    case featuredProducts

    case slider
    case purchases
    case profile
    case buy([Product])
    case emailVerification
    
}
extension MyService: TargetType {
    var baseURL: URL {
        switch self{
        case .getPlistApp(let url):
            return URL(string: url)!
        default:
            return URL(string: "https://v2.3sr0store.com/api")!
        }
    }
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .loginUDID:
            return "/ipastore/device/login"
        case .register:
            return "/user/register"
        case .applications:
            return "/ipastore/applications"
        case .categories:
            return "/categories"
        case .products(id: let id):
            return "/categories/\(id)/products"
        case .searchProducts:
            return "/categories-products"
        case .slider:
            return "/slider"
        case .purchases:
            return "/purchases"
        case .profile:
            return "/users"
        case .buy:
            return "/purchases/create"
        case .loginPhone:
            return "/user/login"
        case .emailVerification:
            return "/user/email/verification-notification"
        case .featuredProducts:
            return "/categories-products"
        default:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .login,.register,.getPlistApp,.buy,.loginUDID,.loginPhone,.emailVerification:
            return .post
        case .applications,.categories,.products,.searchProducts,.slider,.purchases,.profile,.featuredProducts:
            return .get

        }
    }
    var task: Task {
        switch self {
        case   .categories,.products,.slider,.purchases,.profile: // Send no parameters
            return .requestPlain
        case .login(email: let email, password: let password):
            return .requestParameters(parameters: ["email":email,"password":password,"device_name":"ios"], encoding: URLEncoding.default)
        case .loginPhone(number: let phone, code: let code):
            var param:[String:Any] = ["phone_number":phone,"device_name":"ios"]
            param["verification_code"] = code
            print(param)
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .register(email: let email, username: let username, phone: let phone, password: let password,password_confirmation:let password_confirmation):
            return .requestParameters(parameters: ["email":email,"name":username,"phone_number":phone,"password":password,"password_confirmation":password_confirmation,"device_name":"IOS"], encoding: URLEncoding.default)
        case .getPlistApp(_):
            return .requestPlain
        case .searchProducts(let q):
            return .requestParameters(parameters: ["q":q], encoding: URLEncoding.default)
        case .featuredProducts:
            return .requestParameters(parameters: ["filter":"featured"], encoding: URLEncoding.default)
        case .applications(let page):
            return .requestParameters(parameters: ["page":page], encoding: URLEncoding.default)
        case .loginUDID(let udid):
            return .requestParameters(parameters: ["device_udid":udid], encoding: URLEncoding.default)
        case .buy(let ids):
            var productIds:[String:Int] = [:]
            for index in 0..<ids.count{
                productIds["products[\(ids[index].id)]"] = ids[index].id
            }
            return .requestParameters(parameters: productIds, encoding: URLEncoding.default)
        case .emailVerification:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self{
        case .getPlistApp:
//            print(AppTokenCache.get())
            return ["Accept": "application/json","Authorization": "Bearer \(AppTokenCache.get() ?? "")"]
        case .applications,.purchases,.profile,.buy:
            return ["Accept": "application/json","Authorization": "Bearer \(UserProfileCache.get()?.token ?? "")"]
        default:
            return ["Accept": "application/json"]
        }
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
extension MyService {
    func request<R: Codable>(_ response: R.Type) -> R {
        MoyaProvider<Self>.default().request(self, response: response) as! R
    }

    func requestWithoutContainer<R: Codable>(_ response: R.Type) -> R {
        MoyaProvider<Self>.default().requestWithoutContainer(self, response: response) as! R
    }
}
