//
//  RouteDelegateProtocol.swift
//  Pods
//
//  Created by Joey BARBIER on 15/01/2021.
//

import Foundation

public protocol RouteDelegate {
    func dataWillSerialized(data: Data)
}

extension RouteDelegate {
    public func dataWillSerialized(data: Data){}
}
