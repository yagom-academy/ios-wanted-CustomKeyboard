//
//  HangeulCombiner.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

enum HangeulOutputMode {
    case none, add, change, remove
}

enum HangeulInputMode {
    case add, remove, space
}

final class HangeulCombineBuffer {
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
            guard let position = curr?.position.last else {
                return
            }

            switch position {
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
        } while curr != nil && curr?.status != .finished && curr?.unicode != nil
    }
}

final class HangeulCombiner {
    
    private var combinedString: String = ""
    private var outputMode: HangeulOutputMode = .none
    
    func combine(_ last: Hangeul, inputMode: HangeulInputMode) {
        let buffer = HangeulCombineBuffer()
        buffer.append(last)
        
        if buffer.top.isEmpty {
            if buffer.mid.count > 1 {
                combinedString = getCombinedString(with: buffer) ?? ""
                outputMode = .change
            } else {
                guard let midFirstCharacter = buffer.mid.first else {
                    return
                }
                combinedString = getCombinedString(midFirstCharacter) ?? ""
                outputMode = .add
            }
        } else if buffer.mid.isEmpty && buffer.end.isEmpty {
            guard let topFirstCharacter = buffer.top.first else {
                return
            }
            combinedString = getCombinedString(topFirstCharacter) ?? ""
            outputMode = .add
        } else if buffer.end.isEmpty {
            let topPos = buffer.top.first!.position
            if inputMode == .add && buffer.mid.count == 1 && topPos.count > 1 {
                let prevBuffer = HangeulCombineBuffer()
                guard let prevLast = buffer.top.first?.prev else {
                    return
                }
                prevBuffer.append(prevLast)
                combinedString += getCombinedString(with: prevBuffer) ?? ""
            }
            combinedString += getCombinedString(with: buffer) ?? ""
            outputMode = .change
        } else {
            combinedString += getCombinedString(with: buffer) ?? ""
            outputMode = .change
        }
    }
        
    
    private func getCombinedString(_ solo: Hangeul? = nil, with buffer: HangeulCombineBuffer? = nil) -> String? {
        let converter = HangeulConverter()
    
        if solo != nil {
            return converter.toString(from: solo?.unicode)
        }
        
        guard let buffer = buffer else {
            return nil
        }
        
        let dictionary = HangeulDictionary()
        
        if buffer.top.isEmpty {
            if buffer.mid.count == 2 {
                let doubleUnicode = dictionary.getDoubleUnicode(buffer.mid[0], buffer.mid[1])
                return converter.toString(from: doubleUnicode)
            } else if buffer.mid.count == 3 {
                let tripleUnicode = dictionary.getTripleMidUnicode(buffer.mid[0], buffer.mid[1], buffer.mid[2])
                return converter.toString(from: tripleUnicode)
            }
        }
        
        guard let index = getIndexArrayForCombine(with: buffer) else {
            return nil
        }
        let combineUnicode = (index.top * dictionary.midCount * dictionary.endCount) + (index.mid * dictionary.endCount) + index.end + dictionary.baseCode
        
        return converter.toString(from: combineUnicode)
    }
    
    
    private func getIndexArrayForCombine(with buffer: HangeulCombineBuffer) -> (top: Int, mid: Int, end: Int)? {
        let dictionary = HangeulDictionary()
        var midIndex = 0, endIndex = 0
        
        let topIndex = dictionary.getIndex(unicode: buffer.top.first!.unicode, position: .top, unicodeType: .fixed)
        
        if buffer.mid.count == 1 {
            guard let index = dictionary.getIndex(unicode: buffer.mid.first!.unicode, position: .mid, unicodeType: .fixed) else {
                return nil
            }
            midIndex = index
        } else if buffer.mid.count == 2 {
            let doubleMidUnicode = dictionary.getDoubleUnicode(buffer.mid.first!, buffer.mid.last!)
            guard let index = dictionary.getIndex(unicode: doubleMidUnicode, position: .mid, unicodeType: .fixed) else {
                return nil
            }
            midIndex = index
        } else if buffer.mid.count == 3 {
            let tripleUnicode = dictionary.getTripleMidUnicode(buffer.mid[0], buffer.mid[1], buffer.mid[2])
            guard let index = dictionary.getIndex(unicode: tripleUnicode, position: .mid, unicodeType: .fixed) else {
                return nil
            }
            midIndex = index
        }
        
        if buffer.end.isEmpty {
            guard let index = dictionary.getIndex(unicode: HangeulDictionary.fixed.end.blank.rawValue, position: .end, unicodeType: .fixed) else {
                return nil
            }
            endIndex = index
        } else if buffer.end.count == 1 {
            guard let index = dictionary.getIndex(unicode: buffer.end.first?.unicode, position: .end, unicodeType: .fixed) else {
                return nil
            }
            endIndex = index
        } else {
            let doubleEndUnicode = dictionary.getDoubleUnicode(buffer.end.first!, buffer.end.last!)
            guard let index = dictionary.getIndex(unicode: doubleEndUnicode, position: .end, unicodeType: .fixed) else {
                return nil
            }
            endIndex = index
        }
        
        return (topIndex, midIndex, endIndex) as? (top: Int, mid: Int, end: Int)
    }
    
    func getOutputMode() -> HangeulOutputMode {
        return outputMode
    }
    
    func getCombinedString() -> String {
        return combinedString
    }
}
