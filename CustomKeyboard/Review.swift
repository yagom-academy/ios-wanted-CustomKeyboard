//
//  Review.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import Foundation

struct Review: Decodable {
    struct User: Decodable {
        let userName: String
        let profileImage: String
    }
    
    let user: User
    let content: String
    let createdAt: String
}
