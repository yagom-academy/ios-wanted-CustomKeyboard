//
//  User.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/21.
//

import Foundation

struct User: Codable {
    var id: String
    var isAdmin: Bool
    var profileImage: String
    var userName: String
    
    enum CodingKeys : String , CodingKey {
        case id = "_id"
        case isAdmin, profileImage, userName
    }
}
