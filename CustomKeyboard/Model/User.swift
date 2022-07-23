//
//  User.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

struct User: Decodable {

    let userName: String
    let profileImageURL: String

    enum CodingKeys: String, CodingKey {
        case userName
        case profileImageURL = "profileImage"
    }

}
