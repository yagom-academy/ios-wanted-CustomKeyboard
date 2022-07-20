//
//  Hangeul.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/15.
//

import Foundation

enum HangeulEumun {
    case moeum, jaeum
}

enum HangeulUnicodeType {
    case fixed, compatible
}

enum HangeulCombinationStatus {
    case ongoing, finished
}

enum HangeulCombinationPosition {
    case choseong, jungseong, jongseong
}

final class Hangeul {
    var prev: Hangeul?
    var next: Hangeul?
    
    var eumun: HangeulEumun
    var text: String
    var unicode: Int?
    var status: HangeulCombinationStatus
    var position: [HangeulCombinationPosition]
    
    init(_ input: String) {
        self.prev = nil
        self.next = nil
        self.text = input
        self.position = []
        self.eumun = .jaeum
        
        guard input != "Space" else {
            self.unicode = nil
            self.status = .finished
            return
        }
        
        for hangeul in HangeulDictionary.compatible.mid.allCases {
            if hangeul.rawValue == self.unicode {
                self.eumun = .moeum
            }
        }
        
        
        let converter = HangeulConverter()
        self.unicode = converter.toUnicode(from: input)
        self.status = .ongoing
    }
}

extension Hangeul {

    func update(status: HangeulCombinationStatus? = nil, position: HangeulCombinationPosition? = nil) {
        guard let oldUnicode = self.unicode else {
            return
        }
        
        if status != nil {
            self.status = status ?? .ongoing
        }
        
        guard let position = position else {
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
            guard let oldIndex = dictionary.getIndex(of: oldUnicode, in: oldPosition, type: .fixed) else {
                return
            }
            guard let unicode = dictionary.getUnicode(at: oldIndex, in: oldPosition, of: .compatible) else {
                return
            }
            
            oldCompatibleUnicode = unicode
        }
        
        guard let newIndex = dictionary.getIndex(of: oldCompatibleUnicode, in: position, type: .compatible) else {
            return
        }
        let newFixedUnicode = dictionary.getUnicode(at: newIndex, in: position, of: .fixed)
        self.unicode = newFixedUnicode
        
        if self.position.isEmpty {
            self.position.append(position)
        } else if self.position.count > 1 {
            guard let firstPosition = self.position.first else {
                return
            }
            
            if firstPosition == position {
                self.position.removeLast()
            }
        } else {
            self.position.append(position)
        }
    }
}

extension Hangeul {
    
    func canBeJungseong() -> Bool {
        for hangeul in HangeulDictionary.compatible.mid.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        return false
    }
    
    func canBeJongseong() -> Bool {
        for hangeul in HangeulDictionary.compatible.end.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        
        return false
    }
    
    
    func isDoubleMid() -> Bool {
        guard self.canBeJungseong() else {
            return false
        }
        
        for hangeul in HangeulDictionary.compatible.doubleMid.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        
        return false
    }
    
    func canHaveEnd() -> Bool {
        if !self.canCombineWithPreviousCharacter() {
            return false
        } else {
            guard let currentCharacterPosition = self.position.last else {
                return false
            }
            guard let previousCharacterPosition = self.prev?.position.last else {
                return false
            }
        
            if currentCharacterPosition == .jungseong && previousCharacterPosition == .jungseong {
                if self.prev?.prev == nil {
                    return false
                } else if previousCharacterPosition == .jungseong && self.prev?.prev?.status == .finished {
                    return false
                }
            }
        }
        return true
    }
    
    func canBeTripleMid() -> Bool {
        let dictionary = HangeulDictionary()
        
        if self.prev == nil {
            return false
        } else if self.prev?.position.last! != .jungseong {
            return false
        } else if dictionary.getTripleMidUnicode(self.prev!, self, self.next!) == nil {
            return false
        }
        
        return true
    }
    
    
    func canBeDoubleMid() -> Bool {
        let dictionary = HangeulDictionary()

        if !(self.prev?.status == .finished || self.prev?.position.last! != .jungseong) {
            return false
        } else if self.isDoubleMid() {
            return false
        } else if dictionary.getDoubleUnicode(self, self.next!) == nil {
            return false
        }
        
        return true
    }
    
    func canBeDoubleEnd() -> Bool {
        let dictionary = HangeulDictionary()

        if self.prev?.position.last! == .jongseong  {
            return false
        } else if dictionary.getDoubleUnicode(self, self.next!) == nil {
            return false
        }
        
        return true
    }
    
    func canCombineWithPreviousCharacter() -> Bool {
        if self.prev == nil {
            return false
        } else if self.prev?.status == .finished {
            return false
        }
    
        return true
    }
    
}
