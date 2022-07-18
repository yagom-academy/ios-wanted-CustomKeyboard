//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

class HangeulSpecifier {
    
    func specify(_ curr: Hangeul) {
        let judgingMachine = HangeulJudgingMachine()
        let dictionary = HangeulDictionary()
        
        if curr.prev == nil || curr.prev?.status == .finished {
            if curr.phoneme == .vowel {
                if judgingMachine.isDoubleMid(unicode: curr.unicode) {
                    curr.update(newType: .fixed, newStatus: .finished, newPosition: .mid2)
                } else {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid1)
                }
            } else {
                curr.update(newType: .fixed, newStatus: curr.status, newPosition: .top)
            }
            return
        }
        
        let prev = curr.prev!
        
        switch prev.position.last {
        case .top :
            if curr.phoneme == .vowel {
                if judgingMachine.isDoubleMid(unicode: curr.unicode) {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid2)
                } else {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid1)
                }
            } else {
                prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                curr.update(newType: .fixed, newStatus: curr.status, newPosition: .top)
            }
        case .mid1:
            if curr.phoneme == .vowel {
                if judgingMachine.isDoubleMid(unicode: curr.unicode) {
                    prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                    curr.update(newType: .fixed, newStatus: .finished, newPosition: .mid2)
                } else if dictionary.getDoubleUnicode(prev, curr) > 0 {
                    if prev.prev == nil || prev.prev?.status == .finished { // ex. ㅓ ㅔ 의 상태일 때
                        curr.update(newType: .fixed, newStatus: .finished, newPosition: .mid2)
                    } else {
                        curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid2)
                    }
                } else {
                    prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid1)
                }
            } else {
                if prev.prev == nil || prev.prev?.status == .finished {
                    prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .top)
                } else {
                    if judgingMachine.isEnd(unicode: curr.unicode) {
                        curr.update(newType: .fixed, newStatus: curr.status, newPosition: .end1)
                    } else {
                        prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                        curr.update(newType: .fixed, newStatus: curr.status, newPosition: .top)
                    }
                }
            }
        case .mid2:
            if curr.phoneme == .vowel {
                prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                if judgingMachine.isDoubleMid(unicode: curr.unicode) {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid2)
                } else {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid1)
                }
            } else {
                if judgingMachine.isEnd(unicode: curr.unicode) {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .end1)
                } else {
                    prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .top)
                }
            }
        case .end1:
            if curr.phoneme == .vowel {
                prev.prev!.update(newType: prev.prev!.unicodeType, newStatus: .finished, newPosition: (prev.prev?.position.last!)!)
                prev.update(newType: prev.unicodeType, newStatus: prev.status, newPosition: .top)
                if judgingMachine.isDoubleMid(unicode: curr.unicode) {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid2)
                } else {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid1)
                }
            } else {
                if dictionary.getDoubleUnicode(prev, curr) > 0 {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .end2)
                } else {
                    prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .top)
                }
            }
        case .end2:
            if curr.phoneme == .vowel {
                prev.prev!.update(newType: prev.prev!.unicodeType, newStatus: .finished, newPosition: prev.prev!.position.last!)
                prev.update(newType: prev.unicodeType, newStatus: prev.status, newPosition: .top)
                if judgingMachine.isDoubleMid(unicode: curr.unicode) {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid2)
                } else {
                    curr.update(newType: .fixed, newStatus: curr.status, newPosition: .mid1)
                }
            } else {
                prev.update(newType: prev.unicodeType, newStatus: .finished, newPosition: prev.position.last!)
                curr.update(newType: .fixed, newStatus: .ongoing, newPosition: .top)
            }
        default:
            break
        }
        
    }
    
    deinit {
        print("close specifier")
    }
}
