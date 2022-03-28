//
//  Api_Route.swift
//  ArchiExample
//
//  Created by Joey BARBIER on 22/12/2020.
//

import Foundation
import Alamofire

public protocol Route {
    var baseUrl: URL {get}
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: [String: Any] {get}
    var encoding: ParameterEncoding {get}
    var headers: HTTPHeaders? {get}
}

extension Route {
    @discardableResult
    public func call<R: Codable> (withCompletionCall completionCall: @escaping ApiRouter.ApiResponse<R>) -> DataRequest? {
        return ApiRouter.call(withRoute: self) { response in
            switch response.result {
            case .success(let value):
                (self as? RouteDelegate)?.dataWillSerialized(data: value)
                ApiRouter.handlerResult(value, completionCall: completionCall)
            case .failure(let error):
                completionCall(.failure(error))
            }
        }
    }
    
    @discardableResult
    public func call(withHandlerResult handlerResult: @escaping ApiRouter.ApiResponse<Data>) -> DataRequest? {
        return ApiRouter.call(withRoute: self) { response in
            switch response.result {
            case .success(let value):
                handlerResult(.success(value))
            case .failure(let error):
                handlerResult(.failure(error))
            }
        }
    }
    
    @discardableResult
    public func call(withoutHandler handlerResult: @escaping ApiRouter.ApiResponse<Void>) -> DataRequest? {
        return ApiRouter.call(withRoute: self) { response in
            switch response.result {
            case .success:
                handlerResult(.success(()))
            case .failure(let error):
                handlerResult(.failure(error))
            }
        }
    }
}
