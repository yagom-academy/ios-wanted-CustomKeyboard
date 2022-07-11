//
//  ReviewResponse.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

struct ReviewResponse: Decodable {
    let data: [ReviewResult]
}

struct ReviewResult: Decodable {
    let id: String
    let user: ReviewUser
    private let content: String
    let createdAt: String
    
    var rate: String {
        return content.split(separator: "\n").map { String($0) }[0]
    }
    var reviewContent: String {
        return content.split(separator: "\n").map { String($0) }.last ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case user, content, createdAt
        case id = "_id"
    }
}

struct ReviewUser: Decodable {
    let id: String
    let userName: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case userName, profileImage
        case id = "_id"
    }
}
