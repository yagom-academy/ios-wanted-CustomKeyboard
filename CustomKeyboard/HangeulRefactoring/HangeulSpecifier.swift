//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

class HangeulSpecifier {
    
    func specify(_ curr: Hangeul, inputMode: HangeulInputMode) {
        
        switch inputMode {
        case .space:
            curr.update(status: .finished)
        case .remove:
            break
        default:
            specifyInAddMode(curr)
        }
    }
    
    private func specifyInAddMode(_ curr: Hangeul) {
        guard !(curr.prev == nil || curr.prev?.status == .finished) else {
            if curr.isMid() {
                if curr.isDoubleMid() {
                    curr.update(type: .fixed, status: .finished, position: .mid2)
                } else {
                    curr.update(type: .fixed, position: .mid1)
                }
            } else {
                curr.update(type: .fixed, position: .top)
            }
            return
        }
        
        let prev = curr.prev!
        let dictionary = HangeulDictionary()
        
        switch prev.position.last {
        case .top :
            if curr.isMid() {
                if curr.isDoubleMid() {
                    curr.update(type: .fixed, position: .mid2)
                } else {
                    curr.update(type: .fixed, position: .mid1)
                }
            } else {
                prev.update(status: .finished)
                curr.update(type: .fixed, position: .top)
            }
        case .mid1, .mid2:
            if curr.isMid() {
                if curr.isDoubleMid() {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, status: .finished, position: .mid2)
                } else if prev.position.last! == .mid1 && dictionary.getDoubleUnicode(prev, curr) > 0 {
                    if prev.prev == nil || prev.prev?.status == .finished {
                        curr.update(type: .fixed, status: .finished, position: .mid2)
                    } else {
                        curr.update(type: .fixed, position: .mid2)
                    }
                } else {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, position: .mid1)
                }
            } else {
                if prev.cannotHaveEnd() {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, position: .top)
                } else if curr.isEnd() {
                    curr.update(type: .fixed, position: .end1)
                } else {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, position: .top)
                }
            }
        case .end1, .end2:
            if curr.isMid() {
                prev.prev!.update(status: .finished)
                prev.update(type: prev.unicodeType, status: prev.status, position: .top)
                if curr.isDoubleMid() {
                    curr.update(type: .fixed, position: .mid2)
                } else {
                    curr.update(type: .fixed, position: .mid1)
                }
            } else {
                if prev.position.last! == .end1 && dictionary.getDoubleUnicode(prev, curr) > 0 {
                    curr.update(type: .fixed, position: .end2)
                } else {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, position: .top)
                }
            }
        default:
            break
        }
    }
    
    
    
    deinit {
        print("close specifier")
    }
}
