//
//  ReviewModel.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/11.
//

import Foundation

struct ReviewList : Codable{
    let reviewList : [ReviewModel]
}

struct ReviewModel : Codable{
    let user : User
    let content : String
    let createdAt : Date
}

struct User : Codable{
    let userName : String
    let profileImage : String
}
