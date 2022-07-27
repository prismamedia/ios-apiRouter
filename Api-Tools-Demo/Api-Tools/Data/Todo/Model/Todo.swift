//
//  User.swift
//  Api-Tools
//
//  Created by Joey BARBIER on 12/01/2021.
//

import Foundation

class Todo: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
