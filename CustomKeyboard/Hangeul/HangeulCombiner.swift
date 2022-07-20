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
}

// MARK: Public Method

extension HangeulCombineBuffer {
    
    func append(_ currentCharacter: Hangeul?) {
        guard var currentCharacter = currentCharacter else {
            return
        }
        
        repeat {
            guard let position = currentCharacter.position.last else {
                return
            }

            switch position {
            case .choseong:
                self.top.append(currentCharacter)
            case .jungseong:
                self.mid.insert(currentCharacter, at: 0)
            case .jongseong:
                self.end.insert(currentCharacter, at: 0)
            }
            
            guard let previousCharacter = currentCharacter.prev else {
                return
            }
            
            currentCharacter = previousCharacter
        } while currentCharacter.status != .finished && currentCharacter.unicode != nil
    }
}


// MARK: - Variable

final class HangeulCombiner {
    
    private var combinedString: String = ""
    private var outputMode: HangeulOutputMode = .none

}

// MARK: - Public Method

extension HangeulCombiner {
    
    func combine(_ currentCharacter: Hangeul, inputMode: HangeulInputMode) {
        let buffer = HangeulCombineBuffer()
        buffer.append(currentCharacter)
        
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
            let topFirstCharacterPositionList = buffer.top.first!.position
            if inputMode == .add && buffer.mid.count == 1 && topFirstCharacterPositionList.count > 1 {
                let previousBuffer = HangeulCombineBuffer()
                guard let previousCurrentCharacter = buffer.top.first?.prev else {
                    return
                }
                previousBuffer.append(previousCurrentCharacter)
                combinedString += getCombinedString(with: previousBuffer) ?? ""
            }
            combinedString += getCombinedString(with: buffer) ?? ""
            outputMode = .change
        } else {
            combinedString += getCombinedString(with: buffer) ?? ""
            outputMode = .change
        }
    }
        
    func getOutputMode() -> HangeulOutputMode {
        return outputMode
    }
    
    func getCombinedString() -> String {
        return combinedString
    }
}

// MARK: - Private Method

extension HangeulCombiner {
    
    private func getCombinedString(_ onlyOneCharacter: Hangeul? = nil, with buffer: HangeulCombineBuffer? = nil) -> String? {
        let converter = HangeulConverter()
    
        if onlyOneCharacter != nil {
            return converter.toString(from: onlyOneCharacter?.unicode)
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
        
        let topIndex = dictionary.getIndex(of: buffer.top.first!.unicode, in: .choseong, type: .fixed)
        
        if buffer.mid.count == 1 {
            guard let index = dictionary.getIndex(of: buffer.mid.first!.unicode, in: .jungseong, type: .fixed) else {
                return nil
            }
            midIndex = index
        } else if buffer.mid.count == 2 {
            let doubleMidUnicode = dictionary.getDoubleUnicode(buffer.mid.first!, buffer.mid.last!)
            guard let index = dictionary.getIndex(of: doubleMidUnicode, in: .jungseong, type: .fixed) else {
                return nil
            }
            midIndex = index
        } else if buffer.mid.count == 3 {
            let tripleUnicode = dictionary.getTripleMidUnicode(buffer.mid[0], buffer.mid[1], buffer.mid[2])
            guard let index = dictionary.getIndex(of: tripleUnicode, in: .jungseong, type: .fixed) else {
                return nil
            }
            midIndex = index
        }
        
        if buffer.end.isEmpty {
            guard let index = dictionary.getIndex(of: HangeulDictionary.fixed.end.blank.rawValue, in: .jongseong, type: .fixed) else {
                return nil
            }
            endIndex = index
        } else if buffer.end.count == 1 {
            guard let index = dictionary.getIndex(of: buffer.end.first?.unicode, in: .jongseong, type: .fixed) else {
                return nil
            }
            endIndex = index
        } else {
            let doubleEndUnicode = dictionary.getDoubleUnicode(buffer.end.first!, buffer.end.last!)
            guard let index = dictionary.getIndex(of: doubleEndUnicode, in: .jongseong, type: .fixed) else {
                return nil
            }
            endIndex = index
        }
        
        return (topIndex, midIndex, endIndex) as? (top: Int, mid: Int, end: Int)
    }
    
    
}
