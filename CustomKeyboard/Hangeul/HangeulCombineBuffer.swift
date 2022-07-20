//
//  HangeulCombineBuffer.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/20.
//

import Foundation

// MARK: - Variable

//final class HangeulCombineBuffer {
//    var top : [Hangeul]
//    var mid : [Hangeul]
//    var end : [Hangeul]
//    
//    init() {
//        top = []
//        mid = []
//        end = []
//    }
//}
//
//// MARK: Public Method
//
//extension HangeulCombineBuffer {
//    
//    func append(_ currentCharacter: Hangeul?) {
//        guard var currentCharacter = currentCharacter else {
//            return
//        }
//        
//        repeat {
//            guard let position = currentCharacter.position.last else {
//                return
//            }
//
//            switch position {
//            case .choseong:
//                self.top.append(currentCharacter)
//            case .jungseong:
//                self.mid.insert(currentCharacter, at: 0)
//            case .jongseong:
//                self.end.insert(currentCharacter, at: 0)
//            }
//            
//            guard let previousCharacter = currentCharacter.prev else {
//                return
//            }
//            
//            currentCharacter = previousCharacter
//        } while currentCharacter.status != .finished && currentCharacter.unicode != nil
//    }
//}
