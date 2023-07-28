//
//  Moya+Promises.swift
//  talabyeh
//
//  Created by Hussein Work on 26/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Promises
import Moya

extension MoyaProviderType {
    func request<ResultType: Decodable>(_ endPoint: Target, _ mappedCompletion: @escaping ((Result<ResultType, Error>) -> Void)) -> Cancellable {
        return self.requestWithoutContainer(endPoint) { (result: Result<ResponseContainer<ResultType>, Error>) in
            
            
            switch result {
            case .failure(let error):
                if let r = error as? APIError{
                    mappedCompletion(.failure(APIError(message: r.message, statusCode: r.code)))
                    break
                }else{
                    mappedCompletion(.failure(APIError(message: error.localizedDescription, statusCode:400)))
                    break
                }
               
            case .success(let result):
                
                if result.errors != nil {
                   
                    mappedCompletion(.failure(APIError(message: result.message, statusCode: 400)))
                    return
                }
                
                if let results = result.data {
                    mappedCompletion(.success(results))
                } else {
                    mappedCompletion(.failure(APIError(message: result.message, statusCode: 200)))
                }
                break
            }
        }
    }
    
    func requestWithoutContainer<ResultType: Decodable>(_ endPoint: Target, _ mappedCompletion: @escaping ((Result<ResultType, Error>) -> Void)) -> Cancellable {
        
        return self.request(endPoint, callbackQueue: .none, progress: .none) { (result) in
            switch result {
            case .failure(let error):
                mappedCompletion(.failure(error))
            case .success(let response):
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(ResultType.self, from: response.data)
                    
                    var errorsString = ""
                    if let asContainer = result as? ResponseContainerType {
                        if response.statusCode < 200 || response.statusCode >= 400 {
                            if response.statusCode == 403{
                                mappedCompletion(.failure(APIError(message: errorsString, statusCode: response.statusCode)))
                                return
                            }
                            if let response1 = try? response.mapJSON() as? [String:Any]{
                                if let errors = response1["errors"] as? [String:Any]{
                                    print(response1)
                                    for (_, value) in errors {
                                       if let data = value as? Array<String>{
                                           for row in data {
                                               errorsString += "\(row) \n"
                                           }
                                       }
                                    }
                                    mappedCompletion(.failure(APIError(message: errorsString, statusCode: response.statusCode)))
                                    return
                                } else if let massage = response1["message"] as? String{
                                    errorsString = massage
                                    mappedCompletion(.failure(APIError(message: errorsString, statusCode: response.statusCode)))
                                    return
                                } else if let massage = response1["error"] as? String{
                                    errorsString = massage
                                    mappedCompletion(.failure(APIError(message: errorsString, statusCode: response.statusCode)))
                                    return
                                }
                                
                            }
                        }
                    }
                    
                    mappedCompletion(.success(result))
                } catch {
                    let errorResult = try? decoder.decode(APIError.self, from: response.data)
                    
                    print("faild to decode the response: \(error)")
                    if let result = errorResult {
                        mappedCompletion(.failure(result))
                    } else {
                        mappedCompletion(.failure(error))
                    }
                }
            }
        }
    }
}


extension MoyaProvider {
    func request<R: Decodable>(_ target: Target, response: R.Type) -> Promise<R> {
        return Promise { success, failure in
           _ = self.request(target) { (result: Result<R, Error>) in
                switch result {
                case .success(let object):
                    success(object)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }

    func requestWithoutContainer<R: Decodable>(_ target: Target, response: R.Type) -> Promise<R> {
        return Promise { success, failure in
            _ = self.requestWithoutContainer(target) { (result: Result<R, Error>) in
                switch result {
                case .success(let object):
                    success(object)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}



extension TargetType {
    func request<R: Codable>(_ response: R.Type) -> Promise<R> {
        MoyaProvider<Self>.default().request(self, response: response)
    }

    func requestWithoutContainer<R: Codable>(_ response: R.Type) -> Promise<R> {
        MoyaProvider<Self>.default().requestWithoutContainer(self, response: response)
    }
}
