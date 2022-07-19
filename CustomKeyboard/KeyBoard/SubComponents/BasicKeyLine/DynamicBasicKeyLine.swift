//
//  DynamicBasicKeyLine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import Foundation

class DynamicBasicKeyLine: BasicKeyLine {
    
    // MARK: - Properties
    enum State {
        case single
        case double
    }
    
    private var state: State = .single
    
    init() {
        super.init(keys: ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleDynamicBasicKeyState() {
        
        if (self.state == .single) {
            self.state = .double
            toggleKey(to: .double)
        } else {
            self.state = .single
            toggleKey(to: .single)
        }
    }
    
    func toggleKey(to state: State) {
        
        guard super.buttons != nil else { return }
        
        if (state == .single) {
            super.buttons![0].setTitle("ㅂ", for: .normal)
            super.buttons![1].setTitle("ㅈ", for: .normal)
            super.buttons![2].setTitle("ㄷ", for: .normal)
            super.buttons![3].setTitle("ㄱ", for: .normal)
            super.buttons![4].setTitle("ㅅ", for: .normal)
            super.buttons![8].setTitle("ㅐ", for: .normal)
            super.buttons![9].setTitle("ㅔ", for: .normal)
        } else {
            super.buttons![0].setTitle("ㅃ", for: .normal)
            super.buttons![1].setTitle("ㅉ", for: .normal)
            super.buttons![2].setTitle("ㄸ", for: .normal)
            super.buttons![3].setTitle("ㄲ", for: .normal)
            super.buttons![4].setTitle("ㅆ", for: .normal)
            super.buttons![8].setTitle("ㅒ", for: .normal)
            super.buttons![9].setTitle("ㅖ", for: .normal)
        }
        super.buttons!.forEach { $0.tag = Int(UnicodeScalar(($0.currentTitle)!)!.value) }
    }
}
