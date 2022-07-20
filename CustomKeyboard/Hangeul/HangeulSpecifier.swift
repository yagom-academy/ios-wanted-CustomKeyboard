//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

final class HangeulSpecifier {
    
    func specify(_ curr: Hangeul, inputMode: HangeulInputMode) {
        switch inputMode {
        case .space:
            specifyInSpaceMode(curr)
        case .remove:
            specifyInRemoveMode(curr)
        default:
            specifyInAddMode(curr)
        }
    }
    
    private func specifyInSpaceMode(_ curr: Hangeul) {
        guard !curr.isAtStartingLine() else {
            return
        }
        
        curr.prev?.update(status: .finished)
    }
    
    private func specifyInRemoveMode(_ curr: Hangeul) {
        guard curr.status != .finished || curr.value == "Space" else {
            curr.update(status: .ongoing)
            return
        }
        
        if curr.position.count > 1 {
            curr.prev?.update(status: .ongoing)
            guard let firstPosition = curr.position.first else {
                return
            }
            
            curr.update(status: .ongoing, position: firstPosition)
        }
        
    }
    
    private func specifyInAddMode(_ curr: Hangeul) {
        guard !curr.isAtStartingLine() else {
            if curr.isMid() {
                if curr.isDoubleMid() {
                    curr.update(status: .finished, position: .mid)
                } else {
                    curr.update(position: .mid)
                }
            } else {
                curr.update(position: .top)
            }
            return
        }
        
        let prev = curr.prev!
        
        switch prev.position.last {
        case .top :
            if curr.isMid() {
                curr.update(position: .mid)
            } else {
                prev.update(status: .finished)
                curr.update(position: .top)
            }
        case .mid:
            if curr.isMid() {
                if prev.canBeTripleMid() {
                    curr.update(status: .finished, position: .mid)
                } else if curr.isDoubleMid() {
                    prev.update(status: .finished)
                    curr.update(status: .finished, position: .mid)
                } else if prev.canBeDoubleMid() {
                    curr.update(position: .mid)
                } else {
                    prev.update(status: .finished)
                    curr.update(position: .mid)
                }
            } else {
                if prev.canHaveEnd() && curr.isEnd() {
                    curr.update(position: .end)
                } else {
                    prev.update(status: .finished)
                    curr.update(position: .top)
                }
            }
        case .end:
            if curr.isMid() {
                prev.prev?.update(status: .finished)
                prev.update(position: .top)
                curr.update(position: .mid)
            } else {
                if prev.canBeDoubleEnd() {
                    curr.update(position: .end)
                } else {
                    prev.update(status: .finished)
                    curr.update(position: .top)
                }
            }
        default:
            break
        }
    }
}
