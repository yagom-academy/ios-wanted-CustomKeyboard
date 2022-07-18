//
//  HangeulCombiner.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

enum HangeulOutputEditMode {
    case addCharacter, changeCharacter
}

enum HangeulInputMode {
    case add, remove
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
            case .mid1:
                self.mid.insert(curr!, at: 0)
            case .mid2:
                self.mid.append(curr!)
            case .end1:
                self.end.insert(curr!, at: 0)
            case .end2:
                self.end.append(curr!)
            }
            let prev = curr!.prev ?? nil
            curr = prev
        } while curr != nil && curr!.status != .finished
    }
    
}

class HangeulCombiner {
    
    func combine(_ last: Hangeul, editMode: HangeulInputMode) -> (newString: String, mode: HangeulOutputEditMode) {
        
        let buffer = HangeulCombineBuffer()
        buffer.append(last)
        
        if buffer.top.isEmpty {
            if buffer.mid.count == 2 {
                return (getCombinedString(with: buffer), .changeCharacter)
            } else {
                return (getCombinedString(buffer.mid[0]), .addCharacter)
            }
        } else if buffer.mid.isEmpty && buffer.end.isEmpty {
            return (getCombinedString(buffer.top[0]), .addCharacter)
        } else if buffer.end.isEmpty {
            var newString = ""
            let topPos = buffer.top[0].position
            if editMode == .add && buffer.mid.count == 1 && topPos.count > 1 {
                let prevBuffer = HangeulCombineBuffer()
                let prevLast = buffer.top[0].prev!
                prevBuffer.append(prevLast)
                newString += getCombinedString(with: prevBuffer)
            }
            newString += getCombinedString(with: buffer)
            return (newString, .changeCharacter)
        } else {
            return (getCombinedString(with: buffer), .changeCharacter)
        }
    }
        
    
    private func getCombinedString(_ solo: Hangeul = Hangeul("none"), with buffer: HangeulCombineBuffer = HangeulCombineBuffer()) -> String {
        let converter = HangeulConverter()
        let dictionary = HangeulDictionary()
        
        guard solo.unicode == -1 else {
            return converter.toString(from: solo.unicode)
        }
        
        if buffer.top.isEmpty && buffer.mid.count == 2 {
            let doubleUnicode = dictionary.getDoubleUnicode(buffer.mid[0], buffer.mid[1])
            return converter.toString(from: doubleUnicode)
        }
        
        let topIndex = dictionary.getIndex(of: buffer.top.first!)
        var midIndex: Int
        var endIndex: Int
        
        if buffer.mid.count == 1 {
            midIndex = dictionary.getIndex(of: buffer.mid.first!)
        } else {
            let doubleMid = combineDouble(buffer.mid[0], buffer.mid[1])
            midIndex = dictionary.getIndex(of: doubleMid)
        }
        
        if buffer.end.isEmpty {
            endIndex = dictionary.getIndex(of: Hangeul("none"))
        } else if buffer.end.count == 1 {
            endIndex = dictionary.getIndex(of: buffer.end.first!)
        } else {
            let doubleEnd = combineDouble(buffer.end[0], buffer.end[1])
            endIndex = dictionary.getIndex(of: doubleEnd)
        }
        
        let combineUnicode = (topIndex * dictionary.midCount * dictionary.endCount) + (midIndex * dictionary.endCount) + endIndex + dictionary.baseCode
        
        return converter.toString(from: combineUnicode)
    }
    
    
    private func combineDouble(_ first: Hangeul, _ second: Hangeul) -> Hangeul {
        let dictionary = HangeulDictionary()
        let new = Hangeul("none")
        new.value = "some"
        new.unicode = dictionary.getDoubleUnicode(first, second)
        new.unicodeType = .fixed
        if first.position.last! == .end1 {
            new.position.append(.end2)
        } else {
            new.position.append(.mid2)
        }
        
        return new
    }
    
}



/*
 
 
 
 
 
 */
