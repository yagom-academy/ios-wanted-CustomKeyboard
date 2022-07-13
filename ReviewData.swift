//
//  ReviewData.swift
//  CustomKeyboard
//
//  Created by 조성빈 on 2022/07/12.
//

import Foundation

struct ReviewList : Decodable {
    let data : [ReviewData]
}

struct ReviewData : Decodable {
    let user : User
    let content : String
    let createdAt : String
}

struct User : Decodable {
    let userName : String
    let profileImage : String
}

struct uploadData : Encodable {
    let content : String
}
