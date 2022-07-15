//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import Foundation

class KeyboardViewModel {
    private let networkManager = ReviewAPIManager.shared
    
    private var cho: Character = "\u{0000}"
    private var jun: Character = "\u{0000}"
    private var jon: Character = "\u{0000}"
    private var jonFlag: Character = "\u{0000}"
    private var doubleJonFlag: Character = "\u{0000}"
    var junFlag: Character = "\u{0000}"
    
    private var chos: Array<Int> = [0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141,0x3142, 0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e]
    private var juns: Array<Int> = [0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158, 0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161, 0x3162, 0x3163]
    private var jons: Array<Int> = [0x0000, 0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145, 0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e]
    
    private var state = 0
    
    func postReview(content: String, _ completion: @escaping (Result<Post, APIError>) -> Void) -> Review {
        networkManager.postReview(content: content, completion)
        
        let user = User(userName: "Me", profileImage: "https://cdn.imweb.me/upload/S202009105eb5486486105/7335b7dec12be.jpg")
        let review = Review(user: user, content: content, createdAt: "2022-07-14T23:23:25.546Z")
        
        return review
    }
    
    func makeHan() -> Character {
        if(state == 0){
            return "\u{0000}"
        }
        
        if(state == 1){
            return cho
        }
        
//        var choIndex = chos.indexOf(cho.toInt())
//        var junIndex = juns.indexOf(jun.toInt())
//        var jonIndex = jons.indexOf(jon.toInt())
        
//        var makeResult = 0xAC00 + 28 * 21 * (choIndex) + 28 * (junIndex)  + jonIndex
        
        return "\u{0000}"
    }
}
