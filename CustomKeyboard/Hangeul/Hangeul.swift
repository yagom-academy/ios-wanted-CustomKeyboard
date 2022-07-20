//
//  Hangeul.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/15.
//

import Foundation

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
        
        guard input != Text.space else {
            self.unicode = nil
            self.status = .finished
            return
        }
        
        for hangeul in HangeulDictionary.compatible.jungseong.allCases {
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
            guard let oldPosition = self.position.last,
                  let oldIndex = dictionary.getIndex(of: oldUnicode, in: oldPosition, type: .fixed),
                  let unicode = dictionary.getUnicode(at: oldIndex, in: oldPosition, of: .compatible) else {
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
        for hangeul in HangeulDictionary.compatible.jungseong.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        return false
    }
    
    func canBeJongseong() -> Bool {
        for hangeul in HangeulDictionary.compatible.jongseong.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        
        return false
    }
    
    
    func isDoubleJungseong() -> Bool {
        for hangeul in HangeulDictionary.compatible.doubleJungseong.allCases {
            if hangeul.rawValue == self.unicode {
                return true
            }
        }
        
        return false
    }
    
    func canHaveJongseong() -> Bool {
        if self.canCombineWithPreviousCharacter() == false {
            return false
        }
        
        guard let currentCharacterPosition = self.position.last,
              let previousCharacterPosition = self.prev?.position.last else {
            return false
        }
    
        if currentCharacterPosition == .jungseong && previousCharacterPosition == .jungseong {
            if self.prev?.prev == nil {
                return false
            } else if previousCharacterPosition == .jungseong && self.prev?.prev?.status == .finished {
                return false
            }
        }
        
        return true
    }
    
    func canBeTripleJungseong() -> Bool {
        guard let previousCharacter = self.prev, let mostPreviousCharacter = previousCharacter.prev else {
            return false
        }
        
        let dictionary = HangeulDictionary()
        
        if mostPreviousCharacter.position.last! != .jungseong {
            return false
        } else if dictionary.getTripleMidUnicode(mostPreviousCharacter, previousCharacter, self) == nil {
            return false
        }
        
        return true
    }
    
    
    func canBeDoubleJungseong() -> Bool {
        let dictionary = HangeulDictionary()

        if !(self.prev?.status == .finished || self.prev?.position.last! != .jungseong) {
            return false
        } else if self.isDoubleJungseong() {
            return false
        } else if dictionary.getDoubleUnicode(self, self.next!) == nil {
            return false
        }
        
        return true
    }
    
    func canBeDoubleJongseong() -> Bool {
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

