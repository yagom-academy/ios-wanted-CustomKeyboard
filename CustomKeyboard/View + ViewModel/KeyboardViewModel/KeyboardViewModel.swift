//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/14.
//

import Foundation

class KeyboardViewModel {
    var sejongState: SejongState = .writeInitialState
    var currentJungsung: Jungsung? = nil
    var currentLastJongsung: Jongsung? = nil
    
    var result: Observable<String> = Observable("")
    var returnButtonTapped: Observable<Bool> = Observable(false)
    
    var isShift: Observable<Bool> = Observable(false)
    
    var isRemovePhoneme = true
    
    func didTapKeyboardButton(buffer: Compatibility) {
        
        var curr: UInt32? = 0
        
        switch sejongState {
        case .writeInitialState:
            curr = buffer.rawValue
            if buffer.jungsung != nil {
                sejongState = .writeInitialState
            } else {
                sejongState = .writeMiddleState
            }
        case .writeMiddleState:
            if buffer.jungsung != nil {
                let last = result.value.unicodeScalars.removeLast()
                result.value.appendUnicode(Compatibility(rawValue: last.value)?.chosung?.rawValue)
                curr = buffer.jungsung?.rawValue
                sejongState = .writeLastState
            } else {
                curr = buffer.rawValue
                sejongState = .writeMiddleState
            }
        case .writeLastState: // 아
            if buffer.jungsung != nil { // 아 + ㅏ or ㅣ(이중모음)
                // 이중 모음 체크
                let last = result.value.unicodeScalars.last // ㅏ
                if let lastValue = last?.value,
                    let doubleJungsung = mergeJungsung(Jungsung(rawValue: lastValue), buffer.jungsung) { // 이중모음 가능
                    result.value.unicodeScalars.removeLast()
                    curr = doubleJungsung.rawValue
                    sejongState = .writeLastState
                } else { // 이중모음 안되는 경우
                    curr = buffer.rawValue
                    sejongState = .writeInitialState
                }
            } else {
                if let jongsung = buffer.jongsung {
                    curr = jongsung.rawValue
                    sejongState = .alreadyLastState
                } else {
                    curr = buffer.rawValue
                    sejongState = .writeMiddleState
                }
            }
        case .alreadyLastState: // 안 + ㅣ -> 아 ㄴ
            if buffer.jungsung != nil {
                let last = result.value.unicodeScalars.removeLast()
                result.value.appendUnicode(Jongsung(rawValue: last.value)?.chosung?.rawValue)
                curr = buffer.jungsung?.rawValue
                sejongState = .writeLastState
            } else {
                // 이중 자음 체크
                let last = result.value.unicodeScalars.last
                
                if let lastValue = last?.value,
                   let doubleJongsung = mergeDoubleJongsung(Jongsung(rawValue: lastValue), buffer.jongsung) { // 이중 자음 가능
                    result.value.unicodeScalars.removeLast()
                    curr = doubleJongsung.rawValue
                    sejongState = .alreadyDoubleLastState
                } else { // 이중 자음 안되는 경우
                    curr = buffer.rawValue
                    sejongState = .writeMiddleState
                }
            }
        case .alreadyDoubleLastState: // 앉, 았 -> 안자, 아싸
            if buffer.jungsung != nil {
                // 받침이 ㄲ, ㅆ일 때 체크
                guard let lastValue = result.value.unicodeScalars.last?.value else { return }
                
                if let splitJongsung = splitDoubleJongsung(Jongsung(rawValue: lastValue)) { // ㄱㅅ, ㄴㅎ 처럼 쪼개지는 경우
                    result.value.unicodeScalars.removeLast()
                    result.value.appendUnicode(splitJongsung.0.rawValue)
                    result.value.appendUnicode(splitJongsung.1.chosung?.rawValue)
                    curr = buffer.jungsung?.rawValue
                    sejongState = .writeLastState
                } else { // ㄲ, ㅆ 처럼 안쪼개지는 경우
                    result.value.unicodeScalars.removeLast()
                    result.value.appendUnicode(Chosung(rawValue: lastValue)?.rawValue)
                    curr = buffer.jungsung?.rawValue
                    sejongState = .writeLastState
                }
            } else {
                curr = buffer.rawValue
                sejongState = .writeMiddleState
            }
        }
        
        result.value.appendUnicode(curr)
        isShift.value = false
        print(result.value)
    }
    
    func clearAll() {
        self.result.value = ""
    }
    
    func didTapBack() {
        if !result.value.isEmpty {
            if isRemovePhoneme {
                let removed = result.value.unicodeScalars.removeLast()
                if removed == " " {
                    isRemovePhoneme = false
                }
                
                if let jungsung = Jungsung.init(rawValue: removed.value) { // 중성을 지웠을때
                    if let doubleJunsung = splitJungsung(jungsung) { // 이중 종성이 되는 경우
                        // 이중 종성에서 단종성으로 변경하는 경우
                        result.value.appendUnicode(doubleJunsung.0.rawValue)
                        currentJungsung = doubleJunsung.0
                        sejongState = .writeLastState
                    } else {
                        // 단중성을 지우는 경우
                        currentJungsung = nil
                        currentLastJongsung = nil
                        sejongState = .writeMiddleState
                        
                    }
                }
                
                if Chosung.init(rawValue: removed.value) != nil { // 초성을 지웠을때
                    // 단초성과 쌍초성 모두 뒤에를 지운다.
                    if let current = result.value.unicodeScalars.last {
                        
                        if let jongsung = Jongsung.init(rawValue: current.value) {
                            if splitDoubleJongsung(jongsung) != nil {
                                currentLastJongsung = jongsung
                                sejongState = .alreadyDoubleLastState
                            } else {
                                currentLastJongsung = jongsung
                                sejongState = .alreadyLastState
                            }
                        }
                        
                        if let jungsung = Jungsung.init(rawValue: current.value) {
                            currentJungsung = jungsung
                            sejongState = .writeLastState
                        }

                    } else {
                        currentJungsung = nil
                        currentLastJongsung = nil
                        sejongState = .writeInitialState
                    }
                    
                } else if let jongsung = Jongsung.init(rawValue: removed.value) { // 종성을 지웠을때
                    if let doubleJongsung = splitDoubleJongsung(jongsung) {
                        // 이중 종성이 들어와서 단종성으로 변환하는 경우
                        result.value.appendUnicode(doubleJongsung.0.rawValue)
                        currentLastJongsung = doubleJongsung.0
                        sejongState = .alreadyLastState
                    } else if let current = result.value.unicodeScalars.last {
                        // 단 종성이 들어와서 지우는 경우
                        let jongsung = Jongsung.init(rawValue: current.value)
                        currentLastJongsung = jongsung
                        sejongState = .writeLastState
                    }
                }
            } else {
                result.value.removeLast()
                if result.value.isEmpty {
                    isRemovePhoneme = true
                }
            }
        }
    }
    
    func mergeDoubleJongsung(_ jong1: Jongsung?, _ jong2: Jongsung?) -> Jongsung? {
        switch jong1 {
        case .ㄱ:
            if jong2 == .ㅅ { return .ㄱㅅ }
            return nil
        case .ㄴ:
            if jong2 == .ㅈ { return .ㄴㅈ }
            else if jong2 == .ㅎ { return .ㄴㅎ }
            return nil
        case .ㄹ:
            switch jong2 {
            case .ㄱ: return .ㄹㄱ
            case .ㅁ: return .ㄹㅁ
            case .ㅂ: return .ㄹㅂ
            case .ㅅ: return .ㄹㅅ
            case .ㅌ: return .ㄹㅌ
            case .ㅍ: return .ㄹㅍ
            case .ㅎ: return .ㄹㅎ
            default: return nil
            }
        case .ㅂ:
            if jong2 == .ㅅ { return .ㅂㅅ }
            return nil
        default: return nil
        }
    }
    func splitDoubleJongsung(_ jong: Jongsung?) -> (Jongsung, Jongsung)? {
        switch jong {
        case .ㄱㅅ: return (.ㄱ, .ㅅ)
        case .ㄴㅈ: return (.ㄴ, .ㅈ)
        case .ㄴㅎ: return (.ㄴ, .ㅎ)
        case .ㄹㄱ: return (.ㄹ, .ㄱ)
        case .ㄹㅁ: return (.ㄹ, .ㅁ)
        case .ㄹㅂ: return (.ㄹ, .ㅂ)
        case .ㄹㅅ: return (.ㄹ, .ㅅ)
        case .ㄹㅌ: return (.ㄹ, .ㅌ)
        case .ㄹㅍ: return (.ㄹ, .ㅍ)
        case .ㄹㅎ: return (.ㄹ, .ㅎ)
        case .ㅂㅅ: return (.ㅂ, .ㅅ)
        default: return nil
        }
    }
    func mergeJungsung(_ jung1: Jungsung?, _ jung2: Jungsung?) -> Jungsung? {
        switch jung1 {
        case .ㅗ:
            switch jung2 {
            case .ㅏ: return .ㅘ
            case .ㅐ: return .ㅙ
            case .ㅣ: return .ㅚ
            default: return nil
            }
        case .ㅜ:
            switch jung2 {
            case .ㅓ: return .ㅝ
            case .ㅔ: return .ㅞ
            case .ㅣ: return .ㅟ
            default: return nil
            }
        case .ㅡ:
            if jung2 == .ㅣ { return .ㅢ }
            return nil
        case .ㅕ:
            if jung2 == .ㅣ { return .ㅖ }
            return nil
        case .ㅓ:
            if jung2 == .ㅣ { return .ㅔ }
            return nil
        case .ㅏ:
            if jung2 == .ㅣ { return .ㅐ }
            return nil
        case .ㅑ:
            if jung2 == .ㅣ { return .ㅒ }
            return nil
        default: return nil
        }
    }
    
    func splitJungsung(_ jung: Jungsung?) -> (Jungsung, Jungsung)? {
        switch jung {
        case .ㅖ: return (.ㅕ, .ㅣ)
        case .ㅔ: return (.ㅓ, .ㅣ)
        case .ㅐ: return (.ㅏ, .ㅣ)
        case .ㅒ: return (.ㅑ, .ㅣ)
        case .ㅘ: return (.ㅗ, .ㅏ)
        case .ㅙ: return (.ㅗ, .ㅐ)
        case .ㅚ: return (.ㅗ, .ㅣ)
        case .ㅝ: return (.ㅜ, .ㅓ)
        case .ㅞ: return (.ㅜ, .ㅔ)
        case .ㅟ: return (.ㅜ, .ㅣ)
        case .ㅢ: return (.ㅡ, .ㅣ)
        default: return nil
        }
    }
}
