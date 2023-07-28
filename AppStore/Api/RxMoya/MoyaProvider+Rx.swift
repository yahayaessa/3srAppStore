import Foundation
import RxSwift
import Moya

extension MoyaProvider: ReactiveCompatible {}

public extension Reactive where Base: MoyaProviderType {

    /// Designated request-making method.
    ///
    /// - Parameters:
    ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
    /// - Returns: Single response object.
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.failure(error))
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }

    /// Designated request-making method with progress.
    func requestWithProgress(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        let progressBlock: (AnyObserver) -> (ProgressResponse) -> Void = { observer in
            return { progress in
                observer.onNext(progress)
            }
        }

        let response: Observable<ProgressResponse> = Observable.create { [weak base] observer in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: progressBlock(observer)) { result in
                switch result {
                case .success:
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }

        // Accumulate all progress and combine them when the result comes
        return response.scan(ProgressResponse()) { last, progress in
            let progressObject = progress.progressObject ?? last.progressObject
            let response = progress.response ?? last.response
            return ProgressResponse(progress: progressObject, response: response)
        }
    }
    
    func requestWithoutContainer<R: Decodable>(_ endPoint: Base.Target, response: R.Type) -> Single<R> {
        Single.create { [weak base] single in
            let cancellableToken =  base?.requestWithoutContainer(endPoint, { (result: Result<R, Error>) in
                single(result)
            })
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
    func request<R: Decodable>(_ endPoint: Base.Target, response: R.Type) -> Single<R> {
        Single.create { [weak base] single in
            let cancellableToken =  base?.request(endPoint, { (result: Result<R, Error>) in
                single(result)
            })
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}



extension TargetType  {
    func requestWithoutContainer<R: Decodable>( response: R.Type) -> Single<R> {
        let provider = MoyaProvider<Self>.default()
        return Single.create { [provider] single in
            let cancellableToken =  provider.requestWithoutContainer(self, { (result: Result<R, Error>) in
                single(result)
            })
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
    
    func request<R: Decodable>(response: R.Type) -> Single<R> {
        let provider = MoyaProvider<Self>.default()
        return Single.create { [provider] single in
            let cancellableToken =  provider.request(self, { (result: Result<R, Error>) in
                single(result)
            })
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}
