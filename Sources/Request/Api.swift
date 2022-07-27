//
//  Api.swift
//  Ads Showcase
//
//  Created by Joey BARBIER on 18/08/2020.
//  Copyright © 2020 Joey BARBIER. All rights reserved.
//

import Foundation
import Alamofire

open class ApiRouter {
    public typealias ApiResponse<R> = ((Result<R, Error>)->())
}

// MARK: - Call
extension ApiRouter {
    @discardableResult
    internal static func call(withRoute route: Route,
                     completionCall: @escaping ((AFDataResponse<Data>)->())) -> DataRequest
    {
        let urlRequest = route.baseUrl.appendingPathComponent(route.path)
        
        return AF.request(urlRequest,
                          method: route.method,
                          parameters: route.parameters,
                          encoding: route.encoding,
                          headers: route.headers).responseData { response in
                            completionCall(response)
                          }
    }
}

// MARK: - Handler
extension ApiRouter {
    internal static func handlerResult<R: Decodable> (_ data: Data, completionCall: ApiResponse<R>) {
        let result = Result(catching: { try JSONDecoder().decode(R.self, from: data) })
        completionCall(result)
    }
}
