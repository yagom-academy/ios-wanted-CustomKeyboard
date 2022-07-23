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
    
    let text: String
    var unicode: Int?
    var status: HangeulCombinationStatus
    var position: [HangeulCombinationPosition]
    
    private let dictionary = HangeulDictionary()
    
    init(_ input: String) {
        self.prev = nil
        self.next = nil
        self.text = input
        self.position = []
        
        guard input != Text.space else {
            self.unicode = nil
            self.status = .finished
            return
        }
        
        let converter = HangeulConverter()
        self.unicode = converter.toUnicode(from: input)
        self.status = .ongoing
    }
}

// MARK: - Public

extension Hangeul {

    func update(newStatus: HangeulCombinationStatus? = nil, newPosition: HangeulCombinationPosition? = nil) {
        if newStatus != nil {
            self.status = newStatus ?? .ongoing
        }

        guard let newPosition = newPosition else {
            return
        }
        
        self.unicode = getNewFixedUnicodeAccordingTo(newPosition)
     
        if self.position.count > 1 && self.position.first == newPosition {
            self.position.removeLast()
        } else {
            self.position.append(newPosition)
        }
    }
}

extension Hangeul {
    
    func canBecome(_ position: HangeulCombinationPosition) -> Bool {
        guard let unicode = self.unicode else {
            return false
        }
        
        let allCases = dictionary.getAllCases(of: .compatible, in: position)
        
        if allCases.contains(unicode) {
            return true
        }
        return false
    }
    
    func isDoubleJungseong() -> Bool {
        guard let unicode = self.unicode else {
            return false
        }
        
        let allCases = HangeulUnicodeType.Compatible.doubleJungseong.allCases.map {$0.rawValue}
        
        if allCases.contains(unicode) {
            return true
        }
        return false
    }
    
    func canHaveJongseong() -> Bool {
        if self.canCombineWithPreviousLetter() == false {
            return false
        }
        
        guard let letterPosition = self.position.last,
              let previousLetterPosition = self.prev?.position.last else {
            return false
        }
        
        if letterPosition == .jungseong && previousLetterPosition == .jungseong {
            if self.prev?.prev == nil {
                return false
            } else if previousLetterPosition == .jungseong && self.prev?.prev?.status == .finished {
                return false
            }
        }
        return true
    }
    
    func canBeTripleJungseong() -> Bool {
        guard let previousLetter = self.prev else {
            return false
        }
        
        let mostPreviousLetterText: String? = previousLetter.prev?.text
        
        if dictionary.getTripleMidUnicode(mostPreviousLetterText, previousLetter.text, self.text) == nil {
            return false
        }
        return true
    }
    
    
    func canBeDoubleJungseong() -> Bool {
        if self.prev?.prev?.status != .finished && self.prev?.prev?.position.last == .jungseong {
            return false
        } else if self.prev?.isDoubleJungseong() == true {
            return false
        } else if dictionary.getDoubleUnicode(self.prev, self) == nil {
            return false
        }
        return true
    }
    
    func canBeDoubleJongseong() -> Bool {
        if self.prev?.prev?.position.last == .jongseong  {
            return false
        } else if dictionary.getDoubleUnicode(self.prev, self) == nil {
            return false
        }
        return true
    }
    
    func canCombineWithPreviousLetter() -> Bool {
        if self.prev == nil {
            return false
        } else if self.prev?.status == .finished {
            return false
        }
        return true
    }
}

// MARK: - Private

extension Hangeul {
    
    func getNewFixedUnicodeAccordingTo(_ newPosition: HangeulCombinationPosition) -> Int? {
        guard let oldUnicode = self.unicode else {
            return nil
        }

        var oldCompatibleUnicode: Int
        
        if self.position.isEmpty {
            oldCompatibleUnicode = oldUnicode
        } else {
            guard let oldPosition = self.position.last,
                  let oldIndex = dictionary.getIndex(of: oldUnicode, in: oldPosition, type: .fixed),
                  let unicode = dictionary.getUnicode(at: oldIndex, in: oldPosition, of: .compatible) else {
                return nil
            }
            oldCompatibleUnicode = unicode
        }
        guard let newIndex = dictionary.getIndex(of: oldCompatibleUnicode, in: newPosition, type: .compatible),
              let newFixedUnicode = dictionary.getUnicode(at: newIndex, in: newPosition, of: .fixed) else {
            return nil
        }
        return newFixedUnicode
    }
}
