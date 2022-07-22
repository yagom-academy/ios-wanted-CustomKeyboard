//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/14.
//

import Foundation

class KeyboardViewModel {
    // MARK: - Properties
    
    // Result Value State
    var sejongState: SejongState = .writeInitialState
    var result: Observable<String> = Observable("")
    
    // Utility Buttons
    var isShift: Observable<Bool> = Observable(false)
    var returnButtonTapped: Observable<Bool> = Observable(false)
    
    // Delete
    var isDelete: Observable<Bool> = Observable(false)
    var isRemovePhoneme = true
    
    // Keyboard Extension
    var resultCompats: Observable<Character?> = Observable(nil)
    
    func didTapKeyboardButton(buffer: Compatibility) {
        var curr: UInt32? = 0
        isRemovePhoneme = true
        
        switch sejongState {
        case .writeInitialState where buffer.jungsung != nil:
            // 초성이 들어와야 하는 상태에서 초성이 들어온 경우
            curr = buffer.rawValue
            if let last = result.value.unicodeScalars.last {
                if let _ = Chosung(rawValue: last.value) {
                    sejongState = .writeLastState
                } else {
                    sejongState = .writeInitialState
                }
            } else {
                sejongState = .writeInitialState
            }
            
        case .writeInitialState where buffer.jungsung == nil:
            // 초성이 들어와야 하지만 중성이 들어온 경우
            curr = buffer.rawValue
            sejongState = .writeMiddleState

        case .writeMiddleState where buffer.jungsung != nil:
            // 중성이 들어와야 하는 상태에서 중성이 들어온 경우
            let last = result.value.unicodeScalars.removeLast()
            let chosung = Compatibility(rawValue: last.value)?.chosung
            result.value.appendUnicode(chosung?.rawValue)
            curr = buffer.jungsung?.rawValue
            sejongState = .writeLastState
            
        case .writeMiddleState where buffer.jungsung == nil:
            // 중성이 들어와야 하는 상태에서 중성이 안들어온 경우
            curr = buffer.rawValue
            sejongState = .writeMiddleState
            
        case .writeLastState where buffer.jungsung != nil: // 아
            // 종성이 들어와야 하는 상태에서 중성이 들어온 경우
            guard let last = result.value.unicodeScalars.last else {
                return
            }
            
            if let doubleJungsung = mergeJungsung(
                Jungsung(rawValue: last.value),
                buffer.jungsung
            ) {
                // 이중모음 가능
                result.value.unicodeScalars.removeLast()
                curr = doubleJungsung.rawValue
                sejongState = .writeLastState
            } else if let doubleJungsung = mergeJungsung(
                Compatibility(rawValue: last.value)?.jungsung,
                buffer.jungsung
            ) {
                result.value.unicodeScalars.removeLast()
                curr = doubleJungsung.rawValue
                sejongState = .writeLastState
            } else { // 이중모음 안되는 경우
                curr = buffer.rawValue
                sejongState = .writeInitialState
            }
        case .writeLastState where buffer.jungsung == nil:
            // 종성이 들어와야 하는 상태에서 자음이 들어온 경우
            if let jongsung = buffer.jongsung {
                curr = jongsung.rawValue
                sejongState = .alreadyLastState
            } else {
                curr = buffer.rawValue
                sejongState = .writeMiddleState
            }
        case .alreadyLastState where buffer.jungsung != nil: // 안 + ㅣ -> 아 ㄴ
            // 홑받침이 있고, 모음이 들어온 경우
            let last = result.value.unicodeScalars.removeLast()
            let chosung = Jongsung(rawValue: last.value)?.chosung
            result.value.appendUnicode(chosung?.rawValue)
            curr = buffer.jungsung?.rawValue
            sejongState = .writeLastState
            
        case .alreadyLastState where buffer.jungsung == nil:
            // 홑받침이 있고, 자음이 들어온 경우
            let last = result.value.unicodeScalars.last
            
            if let lastValue = last?.value,
               let doubleJongsung = mergeJongsung(
                Jongsung(rawValue: lastValue),
                buffer.jongsung
               ) {
                // 이중 자음 가능
                result.value.unicodeScalars.removeLast()
                curr = doubleJongsung.rawValue
                sejongState = .alreadyDoubleLastState
            } else {
                // 이중 자음 안되는 경우
                curr = buffer.rawValue
                sejongState = .writeMiddleState
            }
        case .alreadyDoubleLastState where buffer.jungsung != nil: // 앉, 았 -> 안자, 아싸
            // 겹받침이 있고, 모음이 들어온 경우
            guard let lastValue = result.value.unicodeScalars.last?.value else {
                return
            }
            
            if let splitJongsung = splitJongsung(Jongsung(rawValue: lastValue)) {
                // ㄱㅅ, ㄴㅎ 처럼 쪼개지는 경우
                result.value.unicodeScalars.removeLast()
                result.value.appendUnicode(splitJongsung.0.rawValue)
                result.value.appendUnicode(splitJongsung.1.chosung?.rawValue)
                curr = buffer.jungsung?.rawValue
                sejongState = .writeLastState
            } else {
                // ㄲ, ㅆ 처럼 안쪼개지는 경우
                result.value.unicodeScalars.removeLast()
                result.value.appendUnicode(Chosung(rawValue: lastValue)?.rawValue)
                curr = buffer.jungsung?.rawValue
                sejongState = .writeLastState
            }
        case .alreadyDoubleLastState where buffer.jungsung == nil:
            // 겹받침이 있고, 자음이 들어온 경우
            curr = buffer.rawValue
            sejongState = .writeMiddleState
        default:
            break
        }
        
        result.value.appendUnicode(curr)
        isShift.value = false
        resultCompats.value = result.value.last
    }
    
    func didTapBack() {
        if !result.value.isEmpty {
            if isRemovePhoneme { // 음소 지우기
                guard let willRemove = result.value.unicodeScalars.last else {
                    return
                }
                
                // 공백일 경우
                if willRemove == " " {
                    isRemovePhoneme = false
                    result.value.unicodeScalars.removeLast()
                    isDelete.value = true
                    return
                }
                
                // 공백이 아닐 경우
                
                // 1. 모음을 지우는 경우
                if let jungsung = Jungsung.init(rawValue: willRemove.value) { // 중성
                    // 이중 중성
                    if let doubleJungsung = splitJungsung(jungsung) { // 과 -> 고 ㅘ -> ㅗ
                        result.value.unicodeScalars.removeLast() // ㄱ
                        
                        if let chosungValue = result.value.unicodeScalars.last?.value,
                           let _ = Chosung(rawValue: chosungValue) {
                            result.value.appendUnicode(doubleJungsung.0.rawValue)
                            sejongState = .writeLastState
                        } else {
                            let compat = doubleJungsung.0.compatibility
                            result.value.appendUnicode(compat.rawValue)
                            sejongState = .writeLastState
                        }
                    } else { // 단 중성 -> 고,ㅗ
                        result.value.unicodeScalars.removeLast() // 고 -> ㄱ
                        // 초성이 있는 경우  // ㄱ
                        if let chosungValue = result.value.unicodeScalars.last?.value,
                           let chosung = Chosung(rawValue: chosungValue)?.compatibility {
                            result.value.unicodeScalars.removeLast()
                            result.value.appendUnicode(chosung.rawValue)
                            sejongState = .writeMiddleState
                        }
                    }
                }
                
                // 2. 자음을 지우는 경우
                if let jongsung = Jongsung(rawValue: willRemove.value) {
                    //이중 자음인 경우
                    if let doubleJongsung = splitJongsung(jongsung) {
                        result.value.unicodeScalars.removeLast()
                        result.value.appendUnicode(doubleJongsung.0.rawValue)
                        sejongState = .alreadyLastState
                    } else { // 단자음
                        result.value.unicodeScalars.removeLast()
                        sejongState = .writeLastState
                    }
                }
                
                // 3. 호환성인 경우
                if Compatibility(rawValue: willRemove.value) != nil { // 안녕하ㅅ
                    result.value.unicodeScalars.removeLast() // 안녕하
                    if let lastValue = result.value.unicodeScalars.last?.value {
                        if Jungsung(rawValue: lastValue) != nil {
                            sejongState = .writeLastState
                        } else {
                            if splitJongsung(Jongsung(rawValue: lastValue)) != nil {
                                sejongState = .alreadyDoubleLastState
                            } else {
                                sejongState = .alreadyLastState
                            }
                        }
                    } else {
                        sejongState = .writeInitialState
                    }
                }
            } else { // 음절 지우기
                result.value.removeLast()
                sejongState = .writeInitialState
                if result.value.isEmpty {
                    isRemovePhoneme = true
                }
            }
        }
        isDelete.value = true
    }
    
    // 공백 추가 메서드
    func addSpace() {
        result.value.append(" ")
        sejongState = .writeInitialState
        resultCompats.value = result.value.last
    }
    
    // 초기화 메서드
    func clearAll() {
        sejongState = .writeInitialState
        result.value = ""
    }
}

private extension KeyboardViewModel {
    /// 두개의 종성을 이중 종성으로 반환하는 메서드
    ///
    /// 반환값이 `nil`인 경우 이중 종성이 불가능하다.
    func mergeJongsung(_ jong1: Jongsung?, _ jong2: Jongsung?) -> Jongsung? {
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
    
    /// 한개의 종성 (이중 종성인 경우) 을 두개의 종성으로 반환하는 메서드
    ///
    /// 반환값이 `nil`인 경우 이중 종성이 분리가 불가능하다.
    func splitJongsung(_ jong: Jongsung?) -> (Jongsung, Jongsung)? {
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
    
    /// 두개의 중성을 이중 중성으로 반환하는 메서드
    ///
    /// 반환값이 `nil`인 경우 이중 중성이 불가능하다.
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
    
    /// 한개의 중성 (이중 중성인 경우) 을 두개의 중성으로 반환하는 메서드
    ///
    /// 반환값이 `nil`인 경우 이중 중성이 분리가 불가능하다.
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
