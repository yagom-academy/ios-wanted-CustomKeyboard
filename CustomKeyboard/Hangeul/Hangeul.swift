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
    case fixed, compatible
}

enum HangeulCombinationStatus {
    case none, ongoing, finished
}

enum HangeulCombinationPosition {
    case none, top, mid, end
}

final class Hangeul {
    var prev: Hangeul?
    var next: Hangeul?
    
    var value: String
    var unicode: Int?
    var status: HangeulCombinationStatus
    var position: [HangeulCombinationPosition]
    
    init(_ input: String) {
        self.prev = nil
        self.next = nil
        self.value = input
        self.position = []
        
        guard input != "Space" else {
            self.unicode = nil
            self.status = .finished
            return
        }
        
        let converter = HangeulConverter()
        self.unicode = converter.toUnicode(from: input)
        self.status = .ongoing
    }
}

extension Hangeul {

    func update(status: HangeulCombinationStatus = .none, position: HangeulCombinationPosition = .none) {
        guard let oldUnicode = self.unicode else {
            return
        }
        
        
        
        if status != .none {
            self.status = status
        }
        
        guard position != .none else {
            return
        }
        
        let dictionary = HangeulDictionary()
        var oldCompatibleUnicode: Int
        
        if self.position.isEmpty {
            oldCompatibleUnicode = oldUnicode
        } else {
            guard let oldPosition = self.position.last else {
                return
            }
            guard let oldIndex = dictionary.getIndex(unicode: oldUnicode, position: oldPosition, unicodeType: .fixed) else {
                return
            }
            let unicode = dictionary.getUnicode(index: oldIndex, position: oldPosition, unicodeType: .compatible)
            
            oldCompatibleUnicode = unicode
        }
        
        guard let newIndex = dictionary.getIndex(unicode: oldCompatibleUnicode, position: position, unicodeType: .compatible) else {
            return
        }
        let newFixedUnicode = dictionary.getUnicode(index: newIndex, position: position, unicodeType: .fixed)
        self.unicode = newFixedUnicode
        
        if self.position.count > 1 && self.position.first! == position {
            self.position.removeLast()
        } else {
            self.position.append(position)
        }
        
    }
}

extension Hangeul {
    
    func isMid() -> Bool {
        for hangeul in HangeulDictionary.compatible.mid.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
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
    
    func canHaveEnd() -> Bool {
        if self.isAtStartingLine() {
            return false
        } else if self.position.last! == .mid && self.prev?.position.last! == .mid {
            if self.prev?.prev == nil {
                return false
            } else if self.prev?.position.last! == .mid && self.prev?.prev?.status == .finished {
                return false
            }
        }
        
        return true
    }
    
    func canBeTripleMid() -> Bool {
        let dictionary = HangeulDictionary()
        
        if self.prev == nil {
            return false
        } else if self.prev?.position.last! != .mid {
            return false
        } else if dictionary.getTripleMidUnicode(self.prev!, self, self.next!) < 0 {
            return false
        }
        
        return true
    }
    
    
    func canBeDoubleMid() -> Bool {
        let dictionary = HangeulDictionary()

        if !(self.prev?.status == .finished || self.prev?.position.last! != .mid) {
            return false
        } else if self.isDoubleMid() {
            return false
        } else if dictionary.getDoubleUnicode(self, self.next!) < 0 {
            return false
        }
        
        return true
    }
    
    func canBeDoubleEnd() -> Bool {
        let dictionary = HangeulDictionary()

        if self.prev?.position.last! == .end  {
            return false
        } else if dictionary.getDoubleUnicode(self, self.next!) < 0 {
            return false
        }
        
        return true
    }
    
    func isAtStartingLine() -> Bool {
        if self.prev == nil {
            return true
        } else if self.prev?.status == .finished {
            return true
        }
    
        return false
    }
    
}
