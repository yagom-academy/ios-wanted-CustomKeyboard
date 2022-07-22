//
//  HangeulList.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/18.
//

import Foundation

// MARK: - Variable

final class HangeulList {
    var head: Hangeul?
    var tail: Hangeul?
    
    init() {
        head = nil
        tail = nil
    }
}

// MARK: - Public

extension HangeulList {
    
    func append(_ data: String) {
        if data == Text.back {
            return
        }
        
       if head == nil || tail == nil {
           head = Hangeul.init(data)
           tail = head
           return
       }
            
       let newNode = Hangeul.init(data)
       tail?.next = newNode
       newNode.prev = tail
       tail = newNode
    }
    
    func removeLast() {
        if head == nil || tail == nil { return }
        
        if head?.next == nil {
            head = nil
            tail = nil
            return
        }
        
        tail?.prev?.next = tail?.next
        tail = tail?.prev
        return
    }
    
    func isEmpty() -> Bool {
        if head == nil || tail == nil {
            return true
        }
        return false
    }
}
