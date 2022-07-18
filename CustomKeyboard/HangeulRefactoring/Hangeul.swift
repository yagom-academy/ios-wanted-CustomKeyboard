//
//  Hangeul.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/15.
//

import Foundation

enum HangeulPhoneme {
    case vowel, consonant
}

enum HangeulUnicodeType {
    case none, fixed, compatible
}

enum HangeulCombinationStatus {
    case none, ongoing, finished
}

enum HangeulCombinationPosition {
    case none, top, mid1, mid2, end1, end2
}

class Hangeul {
    var prev: Hangeul?
    var next: Hangeul?
    var value: String
    var unicode: Int
    var unicodeType: HangeulUnicodeType
    var unicodeIndex: Int
    var status: HangeulCombinationStatus
    var phoneme: HangeulPhoneme
    var position: [HangeulCombinationPosition]
    
    init(_ input: String) {
        
        self.value = input
        self.unicodeType = .compatible
        self.unicodeIndex = -1
        self.status = .ongoing
        self.position = []
        self.prev = nil
        self.next = nil
        
        guard input != "none" else {
            self.unicode = -1
            self.phoneme = .vowel
            return
        }
        
        guard input != "Space" else {
            self.unicode = -2
            self.phoneme = .vowel
            self.status = .finished
            return
        }
        
        let converter = HangeulConverter()
        
        self.unicode = converter.toUnicode(from: input)
        self.phoneme = .consonant
        
        for hangeul in HangeulDictionary.compatible.mid.allCases {
            if hangeul.rawValue == self.unicode {
                self.phoneme = .vowel
                break
            }
        }
    }
    
    func update(type: HangeulUnicodeType = .none, status: HangeulCombinationStatus = .none, position: HangeulCombinationPosition = .none) {
        
        guard !(type == .none && position == .none) else {
            self.status = status
            return
        }
        
        if status != .none {
            self.status = status
        }
        
        if self.position.isEmpty {
            self.position.append(position)
        }
        
        let dictionary = HangeulDictionary()
        
        let oldIndex = dictionary.getIndex(unicode: self.unicode, position: self.position.last!, unicodeType: self.unicodeType)
        let oldCompatibleUnicode = dictionary.getUnicode(index: oldIndex, position: self.position.last!, unicodeType: .compatible)
        
        self.unicode = oldCompatibleUnicode
        self.unicodeType = .compatible
        
        if self.position.last! != position {
            self.position.append(position)
        }
        
        let newIndex = dictionary.getIndex(unicode: self.unicode, position: self.position.last!, unicodeType: self.unicodeType)
        let newUnicode = dictionary.getUnicode(index: newIndex, position: position, unicodeType: type)
        
        self.unicodeIndex = newIndex
        self.unicode = newUnicode
        self.unicodeType = type
        
    }
    
    func isMid() -> Bool {
        if self.phoneme == .vowel {
            return true
        }
        return false
    }
    
    func isEnd() -> Bool {
        for hangeul in HangeulDictionary.compatible.end.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        return false
    }
    
    
    func isDoubleMid() -> Bool {
        for hangeul in HangeulDictionary.compatible.doubleMid.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        return false
    }
    
    func cannotHaveEnd() -> Bool {
        if self.prev == nil {
            return true
        } else if self.prev?.status == .finished {
            return true
        } else if self.position.last! == .mid2 {
            if self.prev?.prev == nil {
                return true
            } else if self.prev?.position.last! == .mid1 && self.prev?.prev?.status == .finished {
                return true
            }
        }
        
        return false
    }
    
}
