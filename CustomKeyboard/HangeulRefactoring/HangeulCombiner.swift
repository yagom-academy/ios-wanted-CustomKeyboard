//
//  HangeulCombiner.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

enum HangeulOutputMode {
    case add, change, remove
}

enum HangeulInputMode {
    case add, remove, space
}

class HangeulCombineBuffer {
    var top : [Hangeul]
    var mid : [Hangeul]
    var end : [Hangeul]
    
    init() {
        top = []
        mid = []
        end = []
    }
    
    func append(_ last: Hangeul) {
        var curr: Hangeul? = last
        
        repeat {
            switch curr!.position.last! {
            case .top:
                self.top.append(curr!)
            case .mid:
                self.mid.insert(curr!, at: 0)
            case .end:
                self.end.insert(curr!, at: 0)
            default:
                break
            }
            let prev = curr!.prev ?? nil
            curr = prev
        } while curr != nil && curr!.status != .finished
    }
}

class HangeulCombiner {
    
    func combine(_ last: Hangeul, inputMode: HangeulInputMode) -> (newString: String, mode: HangeulOutputMode) {
        let buffer = HangeulCombineBuffer()
        buffer.append(last)
        
        if buffer.top.isEmpty {
            if buffer.mid.count == 2 {
                return (getCombinedString(with: buffer), .change)
            } else {
                return (getCombinedString(buffer.mid.first!), .add)
            }
        } else if buffer.mid.isEmpty && buffer.end.isEmpty {
            return (getCombinedString(buffer.top.first!), .add)
        } else if buffer.end.isEmpty {
            var newString = ""
            let topPos = buffer.top.first!.position
            if inputMode == .add && buffer.mid.count == 1 && topPos.count > 1 {
                let prevBuffer = HangeulCombineBuffer()
                let prevLast = buffer.top.first!.prev!
                prevBuffer.append(prevLast)
                newString += getCombinedString(with: prevBuffer)
            }
            newString += getCombinedString(with: buffer)
            return (newString, .change)
        } else {
            return (getCombinedString(with: buffer), .change)
        }
    }
        
    
    private func getCombinedString(_ solo: Hangeul? = nil, with buffer: HangeulCombineBuffer = HangeulCombineBuffer()) -> String {
        let converter = HangeulConverter()
        let dictionary = HangeulDictionary()
        
        guard solo == nil else {
            return converter.toString(from: solo!.unicode)
        }
        
        guard !(buffer.top.isEmpty && buffer.mid.count == 2) else {
            let doubleUnicode = dictionary.getDoubleUnicode(buffer.mid[0], buffer.mid[1])
            return converter.toString(from: doubleUnicode)
        }
        
        let index = getIndexArrayForCombine(with: buffer)
        let combineUnicode = (index.top * dictionary.midCount * dictionary.endCount) + (index.mid * dictionary.endCount) + index.end + dictionary.baseCode
        
        return converter.toString(from: combineUnicode)
    }
    
    
    private func getIndexArrayForCombine(with buffer: HangeulCombineBuffer) -> (top: Int, mid: Int, end: Int) {
        let dictionary = HangeulDictionary()
        var midIndex = 0, endIndex = 0
        
        let topIndex = dictionary.getIndex(unicode: buffer.top.first!.unicode, position: .top, unicodeType: .fixed)
        
        if buffer.mid.count == 1 {
            midIndex = dictionary.getIndex(unicode: buffer.mid.first!.unicode, position: .mid, unicodeType: .fixed)
        } else {
            let doubleMidUnicode = dictionary.getDoubleUnicode(buffer.mid.first!, buffer.mid.last!)
            midIndex = dictionary.getIndex(unicode: doubleMidUnicode, position: .mid, unicodeType: .fixed)
        }
        
        if buffer.end.isEmpty {
            endIndex = dictionary.getIndex(unicode: -1, position: .end, unicodeType: .fixed)
        } else if buffer.end.count == 1 {
            endIndex = dictionary.getIndex(unicode: buffer.end.first!.unicode, position: .end, unicodeType: .fixed)
        } else {
            let doubleEndUnicode = dictionary.getDoubleUnicode(buffer.end.first!, buffer.end.last!)
            endIndex = dictionary.getIndex(unicode: doubleEndUnicode, position: .end, unicodeType: .fixed)
        }
        
        return (topIndex, midIndex, endIndex)
    }
}
