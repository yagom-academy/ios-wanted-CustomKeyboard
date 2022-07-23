//
//  ReviewResponse.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

struct ReviewResponse: Decodable {
    let data: [ReviewResult]
}

struct ReviewResult: Decodable {
    let id: String
    let user: ReviewUser
    private let content: String
    private let createdAt: String
    
    init(id: String, user: ReviewUser, content: String, createdAt: String) {
        self.id = id
        self.user = user
        self.content = content
        self.createdAt = createdAt
    }
    
    var rate: String {
        let rateStr = content.split(separator: "\n").map { String($0) }[0]
        return rateStr.contains("⭐️") ? rateStr : "Rating: 내용없음"
    }
    var reviewContent: String {
        let reviewStr = content.split(separator: "\n").map { String($0) }.last ?? ""
        return reviewStr.contains("Review: ") ? reviewStr : "Review: 내용없음"
    }
    var date: String? {
        return createdAt.toDate?.intervalCurrentTime
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


