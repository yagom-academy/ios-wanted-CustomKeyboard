//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 조성빈 on 2022/07/19.
//

import Foundation

class KeyboardViewModel {
    
    var koreanAutomata = KoreanAutomata()
    
    let keyboardLayout = [
        "ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ",
        "ㅔ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","Shift","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "Del","Space","Return"
    ]
    
    let keyboardLayoutWithShift = [
        "ㅃ","ㅉ","ㄸ","ㄲ","ㅆ","ㅛ","ㅕ","ㅑ","ㅒ",
        "ㅖ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","Shift","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "Del","Space","Return"
    ]
    
    @Published var onShift : Int = 0
    @Published var count : Int = 0
    @Published var buffer : [String] = []
    
    func handleKeyboardInput(_ index : Int) {
        // Save in buffer
        if onShift == 0 {
            if keyboardLayout[index] != "Del", keyboardLayout[index] != "Shift", keyboardLayout[index] != "Return" {
                if keyboardLayout[index] == "Space" {
                    koreanAutomata.buffer.append(" ")
                } else {
                    koreanAutomata.buffer.append(keyboardLayout[index])
                }
            }
        } else {
            if keyboardLayoutWithShift[index] != "Del", keyboardLayoutWithShift[index] != "Shift", keyboardLayoutWithShift[index] != "Return" {
                if keyboardLayoutWithShift[index] == "Space" {
                    koreanAutomata.buffer.append(" ")
                } else {
                    koreanAutomata.buffer.append(keyboardLayoutWithShift[index])
                }
            }
        }
        
        if keyboardLayout[index] == "Del" || keyboardLayoutWithShift[index] == "Del" {
            erase()
        } else if keyboardLayout[index] == "Shift" || keyboardLayoutWithShift[index] == "Shift" {
            pressShift()
        }
    }
    
    func erase() {
        if koreanAutomata.buffer.isEmpty == false {
            koreanAutomata.buffer.removeLast()
        }
    }
    
    func pressShift() {
        if onShift == 0 {
            onShift = 1
        } else {
            onShift = 0
        }
    }
}

extension KeyboardViewModel {
    
    func automata() {
        
        koreanAutomata.initInfo(except: "None")
        KoreanAutomata.AutomataInfo.finalArray = []
        var i = 0
        
        while i < koreanAutomata.buffer.count {
            if koreanAutomata.buffer[i] == " " {
                koreanAutomata.handleSpace(&i)
            }
            else if KoreanAutomata.AutomataInfo.Flag.initial == 0, KoreanAutomata.AutomataInfo.Flag.neuter == 0, KoreanAutomata.AutomataInfo.Flag.secondNeuter == 0 {
                koreanAutomata.handleInitial(&i)
            }
            else if (KoreanAutomata.AutomataInfo.Flag.initial == 0 && KoreanAutomata.AutomataInfo.Flag.neuter == 1) || (KoreanAutomata.AutomataInfo.Flag.initial == 0 && KoreanAutomata.AutomataInfo.Flag.neuter == 0 && KoreanAutomata.AutomataInfo.Flag.secondNeuter == 1) {
                koreanAutomata.handleVowelAtFirst(&i)
            }
            else if KoreanAutomata.AutomataInfo.Flag.initial == 1, KoreanAutomata.AutomataInfo.Flag.neuter == 0, KoreanAutomata.AutomataInfo.Flag.final == 0 {
                koreanAutomata.handleConsonantAtFirst(&i)
            }
            else if KoreanAutomata.AutomataInfo.Flag.initial == 1, KoreanAutomata.AutomataInfo.Flag.neuter == 1, KoreanAutomata.AutomataInfo.Flag.final == 0 {
                koreanAutomata.handleFinalConsonant(&i)
            }
            else if KoreanAutomata.AutomataInfo.Flag.initial == 1, KoreanAutomata.AutomataInfo.Flag.neuter == 1, KoreanAutomata.AutomataInfo.Flag.final == 1, KoreanAutomata.AutomataInfo.Flag.secondFinal == 0 {
                koreanAutomata.handleSecondFinalConsonant(&i)
            }
            else if KoreanAutomata.AutomataInfo.Flag.initial == 1, KoreanAutomata.AutomataInfo.Flag.neuter == 1, KoreanAutomata.AutomataInfo.Flag.final == 1, KoreanAutomata.AutomataInfo.Flag.secondFinal == 1 {
                koreanAutomata.checkWordStatusWithNextInput(&i)
            }
        }
        koreanAutomata.appendToFinalArray()
    }
}
