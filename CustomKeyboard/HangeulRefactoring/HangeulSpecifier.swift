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
            curr.prev?.update(status: .finished)
        case .remove:
            break
        default:
            specifyInAddMode(curr)
        }
    }
    
    private func specifyInAddMode(_ curr: Hangeul) {
        guard !curr.isAtStartingLine() else {
            if curr.isMid() {
                if curr.isDoubleMid() {
                    curr.update(type: .fixed, status: .finished, position: .mid)
                } else {
                    curr.update(type: .fixed, position: .mid)
                }
            } else {
                curr.update(type: .fixed, position: .top)
            }
            return
        }
        
        let prev = curr.prev!
        
        switch prev.position.last {
        case .top :
            if curr.isMid() {
                curr.update(type: .fixed, position: .mid)
            } else {
                prev.update(status: .finished)
                curr.update(type: .fixed, position: .top)
            }
        case .mid:
            if curr.isMid() {
                if curr.isDoubleMid() {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, status: .finished, position: .mid)
                } else if prev.canBeDoubleMid() {
                    if prev.isAtStartingLine() {
                        curr.update(type: .fixed, status: .finished, position: .mid)
                    } else {
                        curr.update(type: .fixed, position: .mid)
                    }
                } else {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, position: .mid)
                }
            } else {
                if prev.canHaveEnd() && curr.isEnd() {
                    curr.update(type: .fixed, position: .end)
                } else {
                    prev.update(status: .finished)
                    curr.update(type: .fixed, position: .top)
                }
            }
        case .end:
            if curr.isMid() {
                prev.prev!.update(status: .finished)
                prev.update(type: prev.unicodeType, status: prev.status, position: .top)
                curr.update(type: .fixed, position: .mid)
            } else {
                if prev.canBeDoubleEnd() {
                    curr.update(type: .fixed, position: .end)
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
