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
    
    var isShift: Observable<Bool> = Observable(false)
    
    typealias Buffer = (chosung: Chosung?, jungsung: Jungsung?, jongsung: Jongsung?)
    
    func didTapKeyboardButton(buffer: Buffer) {
        var curr: Int? = 0
        
        switch sejongState {
        case .writeInitialState: // 초성을 적어야 하는 상태
            curr = buffer.chosung?.rawValue // 1. 초성을 적는다
            sejongState = .writeMiddleState
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
                if isShift.value && buffer.jongsung != .ㄲ && buffer.jongsung != .ㅆ {
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
                if isShift.value {
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
                let splitedDoubleJongsung = splitDoubleJongsungReverse(currentLastJongsung)
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
        
        debugPrint(value)
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
    func splitDoubleJongsungReverse(_ jong: Jongsung?) -> (Jongsung, Jongsung)? {
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
}

// ㅕ ㅣ ㅖ
// ㅓ ㅣ ㅔ
// ㅏ ㅣ ㅐ
// ㅑ ㅣ ㅒ
