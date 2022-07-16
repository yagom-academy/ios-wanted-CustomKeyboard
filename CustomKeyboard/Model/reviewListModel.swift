//
//  getReviewModel.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/14.
//

import Foundation

//typealias reviewList = [review]
//
//struct review: Codable{
//    let user: User
//    let content: String
//    let createdAt: String
//}
//
//struct User: Codable{
//    let userName: String
//    let profileImage: String
//}

struct reviewListModel: Codable { // 대문자
    let data: [review]
}

// MARK: - review
struct review: Codable {
    let user: User
    let content, createdAt: String
}

// MARK: - User
struct User: Codable {
    let userName: String
    let profileImage: String
}
