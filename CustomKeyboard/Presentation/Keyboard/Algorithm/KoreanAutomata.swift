//
//  KoreanAutomata.swift
//  CustomKeyboard
//
//  Created by 조성빈 on 2022/07/21.
//

import Foundation

class KoreanAutomata {
            
    @Published var buffer : [String] = []
    
    let initial = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    let neuter = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ",
                  "ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ",
                  "ㅡ","ㅢ","ㅣ"]

    let neuterForSearch = ["ㅏ","ㅏㅣ","ㅑ","ㅑㅣ","ㅓ","ㅓㅣ","ㅕ","ㅕㅣ","ㅗ",
                  "ㅗㅏ","ㅗㅐ","ㅗㅣ","ㅛ","ㅜ","ㅜㅓ","ㅜㅔ","ㅜㅣ","ㅠ",
                  "ㅡ","ㅡㅣ","ㅣ"]

    let final = ["", "ㄱ", "ㄲ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    enum AutomataInfo {
        enum Flag {
            static var initial = 0
            static var neuter = 0
            static var secondNeuter = 0
            static var neuterTemp = 0
            static var final = 0
            static var secondFinal = 0
            static var finishWord = 0
        }
        
        enum Index {
            static var initial = -1
            static var neuter = -1
            static var secondNeuter = -1
            static var neuterTemp = -1
            static var final = -1
            static var secondFinal = -1
        }
        // 라벨에 표시할 글자
        static var finalArray : [String] = []
    }
    
    func initExceptInitial() {
        AutomataInfo.Flag.neuter = 0
        AutomataInfo.Flag.final = 0
        AutomataInfo.Flag.secondFinal = 0
        AutomataInfo.Index.neuter = -1
        AutomataInfo.Index.final = -1
        AutomataInfo.Index.secondFinal = -1
    }
    
    func initExceptNeuter() {
        AutomataInfo.Flag.initial = 0
        AutomataInfo.Flag.final = 0
        AutomataInfo.Flag.secondFinal = 0
        AutomataInfo.Index.initial = -1
        AutomataInfo.Index.final = -1
        AutomataInfo.Index.secondFinal = -1
    }
    
    func initExceptFinal() {
        AutomataInfo.Flag.initial = 0
        AutomataInfo.Flag.neuter = 0
        AutomataInfo.Flag.secondFinal = 0
        AutomataInfo.Index.initial = -1
        AutomataInfo.Index.neuter = -1
        AutomataInfo.Index.secondFinal = -1
    }
    
    func initAll() {
        AutomataInfo.Flag.initial = 0
        AutomataInfo.Flag.neuter = 0
        AutomataInfo.Flag.secondNeuter = 0
        AutomataInfo.Flag.final = 0
        AutomataInfo.Flag.secondFinal = 0
        AutomataInfo.Index.initial = -1
        AutomataInfo.Index.neuter = -1
        AutomataInfo.Index.secondNeuter = -1
        AutomataInfo.Index.final = -1
        AutomataInfo.Index.secondFinal = -1
    }
    
    func initInfo(except : String) {
        switch except {
        case "initial":
            initExceptInitial()
        case "neuter":
            initExceptNeuter()
        case "final":
            initExceptFinal()
        default:
            initAll()
        }
    }
    
    func appendToFinalArray() {
        var makeWord : Int = 0
        // 초성, 중성, 종성 있을 때
        if AutomataInfo.Flag.initial == 0, AutomataInfo.Flag.neuter == 1 {
            AutomataInfo.finalArray.append(neuter[AutomataInfo.Index.neuter])
        }
        if AutomataInfo.Index.secondFinal != -1, AutomataInfo.Flag.finishWord == 0 {
            AutomataInfo.Index.final = final.firstIndex(of: final[AutomataInfo.Index.final] + final[AutomataInfo.Index.secondFinal]) ?? -1
        }
        if AutomataInfo.Index.initial != -1, AutomataInfo.Index.neuter != -1, AutomataInfo.Index.final != -1 {
            makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28 + AutomataInfo.Index.final
            AutomataInfo.finalArray.append(String(UnicodeScalar(makeWord)!))
            // 초성, 중성 있을 때
        } else if AutomataInfo.Index.initial != -1, AutomataInfo.Index.neuter != -1 {
            makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28
            AutomataInfo.finalArray.append(String(UnicodeScalar(makeWord)!))
            // 초성만 있을 때
        } else if AutomataInfo.Index.initial != -1 {
            AutomataInfo.finalArray.append(initial[AutomataInfo.Index.initial])
        }
    }
    
    func handleSpace(_ i : inout Int) {
        appendToFinalArray()
        AutomataInfo.finalArray.append(" ")
        initInfo(except: "None")
        i += 1
    }
    
    func handleInitial(_ i : inout Int) {
        if neuter.contains(buffer[i]) {
            // 다음 모음이랑 합쳐질 수 없다면
            AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
            AutomataInfo.Flag.neuter = 1
            // 처음에 자음이 왔을 때
        } else if initial.contains(buffer[i]) {
            AutomataInfo.Index.initial = initial.firstIndex(of: buffer[i]) ?? -1
            AutomataInfo.Flag.initial = 1
        }
        i += 1
    }
    
    func handleVowelAtFirst(_ i : inout Int) {
        // 특이 케이스
        if AutomataInfo.Flag.secondNeuter == 1 {
            if buffer[i] == "ㅣ" {
                let tmp = neuter[neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.secondNeuter] + buffer[i]) ?? -1]
                KoreanAutomata.AutomataInfo.finalArray.removeLast()
                AutomataInfo.finalArray.append(neuter[neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.neuterTemp] + tmp) ?? -1])
            }
            AutomataInfo.Index.neuterTemp = -1
            AutomataInfo.Flag.secondNeuter = 0
            AutomataInfo.Index.secondNeuter = -1
        }
        // 다음에 모음이 왔을 때 합쳐질 수 있다면
        else if neuterForSearch.contains(neuter[AutomataInfo.Index.neuter] + buffer[i]) {
            if (neuter[AutomataInfo.Index.neuter] == "ㅗ" && buffer[i] == "ㅏ") || (neuter[AutomataInfo.Index.neuter] == "ㅜ" && buffer[i] == "ㅓ") {
                AutomataInfo.Index.secondNeuter = neuter.firstIndex(of: buffer[i]) ?? -1
                AutomataInfo.Flag.secondNeuter = 1
                AutomataInfo.Index.neuterTemp = AutomataInfo.Index.neuter
            }
            AutomataInfo.finalArray.append(neuter[neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.neuter] + buffer[i]) ?? -1])
            AutomataInfo.Index.neuter = -1
            AutomataInfo.Flag.neuter = 0
        }
        // 다음에 모음이 왔을 때 합쳐질 수 없다면
        else if !neuter.contains(neuter[AutomataInfo.Index.neuter] + buffer[i]), !initial.contains(buffer[i]) {
            AutomataInfo.finalArray.append(neuter[AutomataInfo.Index.neuter])
            AutomataInfo.Flag.neuter = 1
            AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
        }
        // 다음에 자음이 왔을 때
        else if initial.contains(buffer[i]) {
            AutomataInfo.finalArray.append(neuter[AutomataInfo.Index.neuter])
            AutomataInfo.Flag.neuter = 0
            AutomataInfo.Index.neuter = -1
            return
        }
        i += 1
    }
    
    func handleConsonantAtFirst(_ i : inout Int) {
        if initial.contains(buffer[i]) {
            AutomataInfo.finalArray.append(initial[AutomataInfo.Index.initial])
            AutomataInfo.Flag.initial = 1
            AutomataInfo.Index.initial = initial.firstIndex(of: buffer[i]) ?? -1
        } else if neuter.contains(buffer[i]) {
            AutomataInfo.Flag.neuter = 1
            AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
        }
        i += 1
    }
    
    func handleFinalConsonant(_ i : inout Int) {
        // 종성으로 모음이 왔을 때
        if neuter.contains(buffer[i]) {
            if AutomataInfo.Flag.secondNeuter == 1, buffer[i] == "ㅣ" {
                let tmp = neuter[neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.secondNeuter] + buffer[i]) ?? -1]
                AutomataInfo.Index.neuter = neuter.firstIndex(of: neuter[neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.neuterTemp] + tmp) ?? -1]) ?? -1
                AutomataInfo.Index.neuterTemp = -1
                AutomataInfo.Flag.secondNeuter = 0
                AutomataInfo.Index.secondNeuter = -1
            }
            // 기존에 완성되었던 것들 조합해서 AutomataInfo.finish에 append (모음끼리 합쳐질 수 없을 때)
            else if !neuterForSearch.contains(neuter[AutomataInfo.Index.neuter] + buffer[i]) {
                appendToFinalArray()
                AutomataInfo.Flag.neuter = 1
                AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
                initInfo(except: "neuter")
            } else {
                if (neuter[AutomataInfo.Index.neuter] == "ㅗ" && buffer[i] == "ㅏ") || (neuter[AutomataInfo.Index.neuter] == "ㅜ" && buffer[i] == "ㅓ") {
                    AutomataInfo.Index.secondNeuter = neuter.firstIndex(of: buffer[i]) ?? -1
                    AutomataInfo.Flag.secondNeuter = 1
                    AutomataInfo.Index.neuterTemp = AutomataInfo.Index.neuter
                }
                AutomataInfo.Flag.neuter = 1
                AutomataInfo.Index.neuter = neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.neuter] + buffer[i]) ?? -1
            }
        // 종성으로 자음이 왔을 때
        } else if initial.contains(buffer[i]) {
            if final.contains(buffer[i]) {
                AutomataInfo.Index.final = final.firstIndex(of: buffer[i]) ?? -1
                AutomataInfo.Flag.final = 1
            } else {
                appendToFinalArray()
                initInfo(except: "final")
                return
            }
        }
        i += 1
    }
    
    func handleSecondFinalConsonant(_ i : inout Int) {
        // 자음이 또 왔을 때 기존의 종성과 함쳐질 수 있으면
        if final.contains(final[AutomataInfo.Index.final] + buffer[i]) {
            AutomataInfo.Index.secondFinal = final.firstIndex(of: buffer[i]) ?? -1
            AutomataInfo.Flag.secondFinal = 1
        }
        // 자음이 또 왔을 때 기존의 종성과 함쳐질 수 없으면
        else if initial.contains(buffer[i]), !final.contains(final[AutomataInfo.Index.final] + buffer[i]) {
            appendToFinalArray()
            AutomataInfo.Index.initial = initial.firstIndex(of: buffer[i]) ?? -1
            AutomataInfo.Flag.initial = 1
            initInfo(except: "initial")
        }
        // 모음이 왔을 때
        else if neuter.contains(buffer[i]) {
            // 종성을 제외한 기존 글자 append
            let tmp = AutomataInfo.Index.final
            AutomataInfo.Index.final = -1
            appendToFinalArray()
            // 종성 글자를 초성으로 변경, value를 모음 index에 저장
            AutomataInfo.Index.initial = initial.firstIndex(of: final[tmp]) ?? -1
            AutomataInfo.Flag.initial = 1
            // 나머지는 초기화
            initInfo(except: "initial")
            return
        }
        i += 1
    }
    
    func checkWordStatusWithNextInput(_ i : inout Int) {
        // 자음이 왔을 때
        if initial.contains(buffer[i]) {
            // ㄴ, ㅈ 합쳐서 새로운 인덱스로 넣고
            AutomataInfo.Index.final = final.firstIndex(of: final[AutomataInfo.Index.final] + final[AutomataInfo.Index.secondFinal]) ?? -1
            AutomataInfo.Flag.finishWord = 1
            appendToFinalArray()
            initInfo(except: "None")
        }
        // 모음이 왔을 때
        else if neuter.contains(buffer[i]) {
            // 종성을 ㄴ으로 선택하고 앞에 글자 완성시킨다음 append
            let tmp = AutomataInfo.Index.secondFinal
            AutomataInfo.Index.secondFinal = -1
            appendToFinalArray()
            // ㅈ 은 AutomataInfo.Index.initial에 할당
            AutomataInfo.Index.initial = initial.firstIndex(of: final[tmp]) ?? -1
            AutomataInfo.Flag.initial = 1
            initInfo(except: "initial")
        }
    }
    
    func erase() {
        if buffer.isEmpty == false {
            buffer.removeLast()
        }
    }
}

