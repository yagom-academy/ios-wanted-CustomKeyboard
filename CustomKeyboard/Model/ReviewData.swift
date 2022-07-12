//
//  UserData.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import Foundation

class ModelData: Codable {
    var data: [ReviewData] = [ReviewData.Empty]
}

class ReviewData: Codable {
    
    static var Empty = ReviewData(user: User(userName: "", profileImage: ""), content: "", createAt: "")
    
    var user: User
    var content: String
    var createdAt: String
    
    init(user: User, content: String, createAt: String) {
        self.user = user
        self.content = content
        self.createdAt = createAt
        
    }
    
    enum Codingkeys: CodingKey {
        case user
        case content
        case createdAt
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkeys.self)
        user = try values.decode(User.self, forKey: .user)
        content = try values.decode(String.self, forKey: .content)
        createdAt = try values.decode(String.self, forKey: .createdAt)
    }
}

class User: Codable {
    
    var userName: String
    var profileImage: String
    
        init(userName: String, profileImage: String) {
            self.userName = userName
            self.profileImage = profileImage
        }
        
    enum UserCodingKeys: CodingKey {
        case userName
        case profileImage
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)
        userName = try values.decode(String.self, forKey: .userName)
        profileImage = try values.decode(String.self, forKey: .profileImage)
    }
}
