//
//  Review.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

struct Post: Codable {
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content
    }
}
