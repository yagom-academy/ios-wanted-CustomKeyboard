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
    var value = ""
    var result: Observable<String> = Observable("")
    var returnButtonTapped: Observable<Bool> = Observable(false)
    
    var isShift: Observable<Bool> = Observable(false)
    
    let doubleJaum: [Chosung] = [.ㄲ,.ㄸ,.ㅃ,.ㅆ,.ㅉ]
    var isRemovePhoneme = true
    
    typealias Buffer = (chosung: Chosung?, jungsung: Jungsung?, jongsung: Jongsung?)
    
    func didTapKeyboardButton(buffer: Buffer) {
        var curr: Int? = 0
        print(sejongState)
        switch sejongState {
        case .writeInitialState: // 초성을 적어야 하는 상태
            if buffer.jungsung != nil {
                curr = buffer.jungsung?.rawValue
                sejongState = .writeInitialState
            } else {
                curr = buffer.chosung?.rawValue // 1. 초성을 적는다
                sejongState = .writeMiddleState
            }

        case .writeMiddleState: // 중성을 적어야 하는 상태
            if buffer.jungsung != nil {
                curr = buffer.jungsung?.rawValue // 1. 중성을 적는다
                currentJungsung = buffer.jungsung
                sejongState = .writeLastState
            } else {
                curr = buffer.chosung?.rawValue
                sejongState = .writeMiddleState
            }
        case .writeLastState: // 종성을 적어야 하는 상태
            if buffer.jungsung != nil { // 모음이 들어오는 경우
                let doubleJungsung = mergeJungsung(currentJungsung, buffer.jungsung)
                if doubleJungsung != nil {
                    value.unicodeScalars.removeLast()
                    currentJungsung = doubleJungsung
                    curr = doubleJungsung?.rawValue
                } else {
                    curr = buffer.jungsung?.rawValue
                }
                sejongState = .writeLastState

            } else {
                if buffer.jongsung != .ㄲ && buffer.jongsung != .ㅆ && doubleJaum.contains(buffer.chosung!) {
                    curr = buffer.chosung?.rawValue
                    sejongState = .writeMiddleState
                } else {
                    curr = buffer.jongsung?.rawValue // 자음이 들어오면
                    currentLastJongsung = buffer.jongsung
                    sejongState = .alreadyLastState
                }
            }
        case .alreadyLastState: // 종성을 이미 적은 상태
            if buffer.jungsung != nil { // 모음이 들어오는 경우                       안 -> 아, ㄴ -> 아ㄴ -> 아니
                value.unicodeScalars.removeLast()
                value.appendUnicode(currentLastJongsung?.chosung?.rawValue)
                curr = buffer.jungsung?.rawValue
                currentJungsung = buffer.jungsung
                currentLastJongsung = nil
                sejongState = .writeLastState
            } else { // 자음이 들어오는 경우                                     안, ㅎ -> 아, ㄴ, ㅎ -> 않
                if let chosung = buffer.chosung,
                   doubleJaum.contains(chosung) {
                    curr = buffer.chosung?.rawValue
                    sejongState = .writeMiddleState
                } else {
                    let mergedJongsung = mergeDoubleJongsung(currentLastJongsung, buffer.jongsung)
                    if mergedJongsung != nil {
                        value.unicodeScalars.removeLast()
                        curr = mergedJongsung?.rawValue
                        currentLastJongsung = mergedJongsung
                        sejongState = .alreadyDoubleLastState
                    } else {
                        
                        curr = buffer.chosung?.rawValue
                        sejongState = .writeMiddleState
                    }
                }
            }
        case .alreadyDoubleLastState: // 종성이 겹받침인 경우      ex => 않, ㅣ -> 아, ㄶ, ㅣ -> 안, ㄶ, ㅣ -> 안ㅎ, ㅣ -> 안히
            if buffer.jungsung != nil { // 모음이 들어온 경우
                value.unicodeScalars.removeLast()
                let splitedDoubleJongsung = splitDoubleJongsung(currentLastJongsung)
                let jong1 = splitedDoubleJongsung?.0
                let jong2 = splitedDoubleJongsung?.1
                
                value.appendUnicode(jong1?.rawValue)
                value.appendUnicode(jong2?.chosung?.rawValue)
                curr = buffer.jungsung?.rawValue
                currentJungsung = buffer.jungsung
                currentLastJongsung = nil
                sejongState = .writeLastState
            } else { // 자음이 들어온 경우                         ex =>    않, ㅈ -> 않ㅈ
                curr = buffer.chosung?.rawValue
                currentLastJongsung = nil
                sejongState = .writeMiddleState
            }
        }
        value.appendUnicode(curr)
        result.value = value
        isShift.value = false
        isRemovePhoneme = true
        
        debugPrint(value)
    }
    
    func clearAll() {
        self.result.value = ""
        self.value = ""
    }
    
    
    func didTapBack() {
        if !result.value.isEmpty {
            if isRemovePhoneme {
                let removed = result.value.unicodeScalars.removeLast()
                if removed == " " {
                    isRemovePhoneme = false
                }
                
                if let jungsung = Jungsung.init(rawValue: Int(removed.value)) { // 중성을 지웠을때
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
                
                if Chosung.init(rawValue: Int(removed.value)) != nil { // 초성을 지웠을때
                    // 단초성과 쌍초성 모두 뒤에를 지운다.
                    if let current = result.value.unicodeScalars.last {
                        
                        if let jongsung = Jongsung.init(rawValue: Int(current.value)) {
                            if splitDoubleJongsung(jongsung) != nil {
                                currentLastJongsung = jongsung
                                sejongState = .alreadyDoubleLastState
                            } else {
                                currentLastJongsung = jongsung
                                sejongState = .alreadyLastState
                            }
                        }
                        
                        if let jungsung = Jungsung.init(rawValue: Int(current.value)) {
                            currentJungsung = jungsung
                            sejongState = .writeLastState
                        }

                    } else {
                        currentJungsung = nil
                        currentLastJongsung = nil
                        sejongState = .writeInitialState
                    }
                    
                } else if let jongsung = Jongsung.init(rawValue: Int(removed.value)) { // 종성을 지웠을때
                    if let doubleJongsung = splitDoubleJongsung(jongsung) {
                        // 이중 종성이 들어와서 단종성으로 변환하는 경우
                        result.value.appendUnicode(doubleJongsung.0.rawValue)
                        currentLastJongsung = doubleJongsung.0
                        sejongState = .alreadyLastState
                    } else if let current = result.value.unicodeScalars.last {
                        // 단 종성이 들어와서 지우는 경우
                        let jongsung = Jongsung.init(rawValue: Int(current.value))
                        currentLastJongsung = jongsung
                        sejongState = .writeLastState
                    }
                }
                value = result.value
                
            } else {
                result.value.removeLast()
                value = result.value
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
