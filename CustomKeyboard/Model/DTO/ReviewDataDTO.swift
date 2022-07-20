//
//  Review.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

struct ReviewDataDTO: Decodable {
    let datas: [ReviewResult]
    
    enum CodingKeys: String, CodingKey {
        case datas = "data"
    }
}
