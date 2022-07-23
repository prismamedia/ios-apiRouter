//
//  Users.swift
//  Api-Tools
//
//  Created by Joey BARBIER on 12/01/2021.
//

import Foundation
import OrkaApiRouter
import Alamofire

extension ApiRouter {
    enum Todo: Route {
        case list
        case get(id: String)
    }
}

extension ApiRouter.Todo {
    var baseUrl: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .list:
            return "/todos"
        case .get(let id):
            return "/todos/\(id)"
        }
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    var headers: HTTPHeaders? {
        return nil
    }
}

extension ApiRouter.Todo: RouteDelegate {
    func dataWillSerialized(data: Data) {
        print("[DELEGATE]----> dataWillSerialization")
    }
}
