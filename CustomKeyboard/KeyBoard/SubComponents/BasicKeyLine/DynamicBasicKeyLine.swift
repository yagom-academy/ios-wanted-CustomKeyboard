//
//  DynamicBasicKeyLine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import Foundation

final class DynamicBasicKeyLine: BasicKeyLine {
    
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
    
    // MARK: - Public 메서드
    func toggleDynamicBasicKeyState() -> State {
        
        if (state == .single) {
            state = .double
            toggleKey(to: .double)
            return .double
        } else {
            state = .single
            toggleKey(to: .single)
            return .single
        }
    }
    
    // MARK: - Private 메서드
    private func toggleKey(to state: State) {
        
        guard super.buttons != nil,
              let buttonsCount = super.buttons?.count,
              buttonsCount >= 9 else { return }

        if (state == .single) {
            super.buttons?[safe: 0]?.setTitle("ㅂ", for: .normal)
            super.buttons?[safe: 1]?.setTitle("ㅈ", for: .normal)
            super.buttons?[safe: 2]?.setTitle("ㄷ", for: .normal)
            super.buttons?[safe: 3]?.setTitle("ㄱ", for: .normal)
            super.buttons?[safe: 4]?.setTitle("ㅅ", for: .normal)
            super.buttons?[safe: 8]?.setTitle("ㅐ", for: .normal)
            super.buttons?[safe: 9]?.setTitle("ㅔ", for: .normal)
        } else {
            super.buttons?[safe: 0]?.setTitle("ㅃ", for: .normal)
            super.buttons?[safe: 1]?.setTitle("ㅉ", for: .normal)
            super.buttons?[safe: 2]?.setTitle("ㄸ", for: .normal)
            super.buttons?[safe: 3]?.setTitle("ㄲ", for: .normal)
            super.buttons?[safe: 4]?.setTitle("ㅆ", for: .normal)
            super.buttons?[safe: 8]?.setTitle("ㅒ", for: .normal)
            super.buttons?[safe: 9]?.setTitle("ㅖ", for: .normal)
        }
        super.buttons?.forEach { button in
            guard let buttonTitle = button.currentTitle,
                  let unicodeScalar = UnicodeScalar(buttonTitle) else { return }
            button.tag = Int(unicodeScalar.value)
        }
    }
}
