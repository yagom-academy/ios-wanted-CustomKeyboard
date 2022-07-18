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

enum HangeulCombinationStatus {
    case ongoing, finished
}

enum HangeulCombinationPosition {
    case top, mid1, mid2, end1, end2
}

/*
 
  ----------------
 |  top1  |  top2 |  초성 -> top2까지 들어오면 초성의 자리는 꽉 찬 것.(이하 동일)
  ----------------
 |  mid1  |  mid2 |  중성
  ----------------
 |  end1  |  end2 |  종성
  ----------------
 
 ex.
    pos가 mid1인 한글 인스턴스 뒤에 모음인 한글 인스턴스가 들어오는 경우
        if 앞선 한글과 뒤 한글이 겹모음이 될 수 있는지
            if mid1 앞에 초성이 존재하는지
                뒤 한글 status는 onGoing으로 고정
            else
                뒤 한글 status는 finished로 고정
        else
            앞 한글 status는 finished로 고정
            뒤 한글 status는 onGoing으로 고정
 
 
 */



class Hangeul {
    var prev: Hangeul?
    var next: Hangeul?
    
    var value: String
    var unicode: Int
    var unicodeType: HangeulUnicodeType
    var status: HangeulCombinationStatus
    let phoneme: HangeulPhoneme
    var position: [HangeulCombinationPosition]
    
    init(_ input: String) {
        
        self.value = input
        self.unicodeType = .compatible
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
        let judgingMachine = HangeulJudgingMachine()
        
        self.unicode = converter.toUnicode(from: input)
       
        
        if judgingMachine.isMid(unicode: self.unicode) {
            self.phoneme = .vowel
        } else {
            self.phoneme = .consonant
        }
    }
    
    func update(newType: HangeulUnicodeType, newStatus: HangeulCombinationStatus, newPosition: HangeulCombinationPosition) {
        self.status = newStatus
        
        let dictionary = HangeulDictionary()
        if self.position.isEmpty {
            self.position.append(newPosition)
        }
        
        let oldIndex = dictionary.getIndex(of: self)
        let oldCompatibleUnicode = dictionary.getUnicode(index: oldIndex, in: self.position.last!, unicodeType: .compatible)
        
        self.unicode = oldCompatibleUnicode
        self.unicodeType = .compatible
        if self.position.last! != newPosition {
            self.position.append(newPosition)
        }
        let newIndex = dictionary.getIndex(of: self)
        let newUnicode = dictionary.getUnicode(index: newIndex, in: newPosition, unicodeType: newType)
        self.unicode = newUnicode
        self.unicodeType = newType
        
    }
}

class HangeulList {
    var head: Hangeul?
    var tail: Hangeul?
    
    init() {
        head = nil
        tail = nil
    }
    
    func append(data: String) {
            
       //연결 리스트가 빈 경우, Node를 생성 후 head, tail로 지정한다
       if head == nil || tail == nil {
           head = Hangeul.init(data)
           tail = head
           return
       }
            
       let newNode = Hangeul.init(data)
       tail?.next = newNode
       newNode.prev = tail!
       tail = newNode
    }
    
    func removeLast() {
        
        if head == nil || tail == nil { return }
        
        //head를 삭제하는 경우(연결 리스트에 노드가 1개밖에 없는 경우)
        if head?.next == nil {
            head = nil
            tail = nil
            return
        }
        
        tail?.prev!.next = tail!.next
        tail = tail?.prev
        return
    }
    
    func getLastFinished() -> Hangeul? {
        
        var curr: Hangeul? = tail
        
        while curr != nil && curr!.status != .finished {
            let prev = curr!.prev!
            curr = prev
        }
        
        return curr
    }

    func isEmpty() -> Bool {
        if head == nil && tail == nil {
            return true
        }
        return false
    }
}

