//
//  StatusManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/14.
//

import Foundation

class StatusManager {
    
    static let shared = StatusManager()
    private init() { }
    
    private var status: HG.Status = .start
    private var statusStack: [HG.Status] = [.start]
    
    func update(_ buffer: [Int], _ new: Int, _ mode: HG.Mode) {
        
        var prev = -1
        var mostPrev = -1
        
        if !buffer.isEmpty {
            prev = buffer.last!
        }
        
        if buffer.count > 1 {
            mostPrev = buffer[buffer.count - 2]
        }
        
        if mode == .space {
            setStatus(.space)
        } else if mode == .back {
            statusStack.removeLast()
            status = statusStack.last ?? .start
        } else {
            let charKind: HG.Kind = isMid(new, .compatible) ? .vowel : .consonant
            
            switch status {
            case .start, .space:
                if charKind == .consonant {
                    setStatus(.top)
                } else {
                    setStatus(.mid)
                }
            case .top:
                if charKind == .vowel {
                    setStatus(.mid)
                } else {
                    status = .finishPassOne
                }
            case .mid:
                if isTop(mostPrev, .fixed) && isEnd(new, .compatible) {
                    setStatus(.end)
                } else if canBeDouble(prev, new, .mid) {
                    setStatus(.doubleMid)
                } else {
                    status = .finishPassOne
                }
            case .doubleMid:
                if isTop(mostPrev, .fixed) && isEnd(new, .compatible) {
                    setStatus(.end)
                } else {
                    status = .finishPassOne
                }
            case .end:
                if canBeDouble(prev, new, .end) {
                    setStatus(.doubleEnd)
                } else if charKind == .vowel {
                    status = .finishPassTwo
                    statusStack.removeLast()
                    statusStack.append(.top)
                } else {
                    status = .finishPassOne
                }
            case .doubleEnd:
                if charKind == .vowel {
                    status = .finishPassTwo
                    statusStack.removeLast()
                    statusStack.append(.end)
                    statusStack.append(.top)
                } else {
                    status = .finishPassOne
                }
            default:
                break
            }
        }
    }
    
    
    func refresh(_ input: Int) {
        switch status {
        case .finishPassOne:
            if isMid(input, .compatible) {
                setStatus(.mid)
            } else {
                setStatus(.top)
            }
            break
        case .finishPassTwo:
            setStatus(.mid)
        default:
            break
        }
    }
    
    private func setStatus(_ status: HG.Status) {
        self.status = status
        statusStack.append(status)
    }
    
    func getStatus() -> HG.Status {
        return status
    }
    
    func close() {
        status = .start
        statusStack = []
    }
    
    func doesDoubleMidHaveTop() -> Bool {
        if statusStack.count > 2 && statusStack[statusStack.count - 3] == .top {
            return true
        }
        return false
    }
}
