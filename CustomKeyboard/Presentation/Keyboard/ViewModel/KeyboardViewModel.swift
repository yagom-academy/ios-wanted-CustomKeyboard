//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 조성빈 on 2022/07/19.
//

import Foundation

class KeyboardViewModel {
    let initial = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    let neuter = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ",
                  "ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ",
                  "ㅡ","ㅢ","ㅣ"]

    let neuterForSearch = ["ㅏ","ㅏㅣ","ㅑ","ㅑㅣ","ㅓ","ㅓㅣ","ㅕ","ㅕㅣ","ㅗ",
                  "ㅗㅏ","ㅗㅐ","ㅗㅣ","ㅛ","ㅜ","ㅜㅓ","ㅜㅔ","ㅜㅣ","ㅠ",
                  "ㅡ","ㅡㅣ","ㅣ"]

    let final = ["", "ㄱ", "ㄲ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    let consonant = [
        "ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ",
        "ㅔ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","변환","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "지움","스페이스","엔터"
    ]

    let doubleConsonant = [
        "ㅃ","ㅉ","ㄸ","ㄲ","ㅆ","ㅛ","ㅕ","ㅑ","ㅒ",
        "ㅖ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","변환","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "지움","스페이스","엔터"
    ]
    
    @Published var isShift : Int = 0
    @Published var buffer : [String] = []
    @Published var count : Int = 0
        
    func processKeyboardInput(_ index : Int) {
        // Save in buffer
        if isShift == 0 {
            if consonant[index] != "지움", consonant[index] != "변환", consonant[index] != "엔터" {
                if consonant[index] == "스페이스" {
                    buffer.append(" ")
                } else {
                    buffer.append(consonant[index])
                }
            }
        } else {
            if doubleConsonant[index] != "지움", doubleConsonant[index] != "변환", doubleConsonant[index] != "엔터" {
                if doubleConsonant[index] == "스페이스" {
                    buffer.append(" ")
                } else {
                    buffer.append(doubleConsonant[index])
                }
            }
        }
        
        if consonant[index] == "지움" || doubleConsonant[index] == "지움" {
            erase()
        } else if consonant[index] == "변환" || doubleConsonant[index] == "변환" {
            pressUp()
        }
    }
    
    func pressUp() {
        if isShift == 0 {
            isShift = 1
        } else {
            isShift = 0
        }
    }
}

extension KeyboardViewModel {
    
    enum AutomataInfo {
        enum Flag {
            static var initial = 0
            static var neuter = 0
            static var final = 0
            static var secondFinal = 0
        }
        
        enum Index {
            static var initial = -1
            static var neuter = -1
            static var final = -1
            static var secondFinal = -1
        }
        // 라벨에 표시할 글자
        static var finish : [String] = []
    }
    
    func initInfo() {
        AutomataInfo.Flag.initial = 0
        AutomataInfo.Flag.neuter = 0
        AutomataInfo.Flag.final = 0
        AutomataInfo.Flag.secondFinal = 0
        
        AutomataInfo.Index.initial = -1
        AutomataInfo.Index.neuter = -1
        AutomataInfo.Index.final = -1
        AutomataInfo.Index.secondFinal = -1
        
        AutomataInfo.finish = []
    }
    
    func automata() -> [String] {
        
        initInfo()
        
        var i = 0
        while i < buffer.count {
            // space
            if buffer[i] == " " {
                var makeWord : Int = 0
                // 초성, 중성, 종성 있을 때
                if AutomataInfo.Index.initial != -1, AutomataInfo.Index.neuter != -1, AutomataInfo.Index.final != -1 {
                    makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28 + AutomataInfo.Index.final
                    AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                    // 초성, 중성 있을 때
                } else if AutomataInfo.Index.initial != -1, AutomataInfo.Index.neuter != -1 {
                    makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28
                    AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                    // 초성만 있을 때
                } else if AutomataInfo.Index.initial != -1 {
                    AutomataInfo.finish.append(initial[AutomataInfo.Index.initial])
                }
                AutomataInfo.finish.append(" ")
                
                // 초기화
                initInfo()
                i += 1
                continue
            }
            
            // 글자의 시작일 때
            if AutomataInfo.Flag.initial == 0, AutomataInfo.Flag.neuter == 0 {
                // 처음에 모음이 왔을 때
                if neuter.contains(buffer[i]) {
                    // 다음 모음이랑 합쳐질 수 없다면
                    AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
                    AutomataInfo.Flag.neuter = 1
                    i += 1
                    continue
                    // 처음에 자음이 왔을 때
                } else if initial.contains(buffer[i]) {
                    AutomataInfo.Index.initial = initial.firstIndex(of: buffer[i]) ?? -1
                    AutomataInfo.Flag.initial = 1
                    i += 1
                    continue
                }
            } else if AutomataInfo.Flag.initial == 0, AutomataInfo.Flag.neuter == 1 {
                // 다음에 모음이 왔을 때 합쳐질 수 잇다면
                if neuterForSearch.contains(neuter[AutomataInfo.Index.neuter] + buffer[i]) {
                    AutomataInfo.finish.append(neuter[neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.neuter] + buffer[i]) ?? -1])
                    AutomataInfo.Flag.neuter = 0
                    AutomataInfo.Index.neuter = -1
                }
                // 다음에 모음이 왔을 때 합쳐질 수 없다면
                else if !neuter.contains(neuter[AutomataInfo.Index.neuter] + buffer[i]), !initial.contains(buffer[i]) {
                    AutomataInfo.finish.append(neuter[AutomataInfo.Index.neuter])
                    AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
                }
                // 다음에 자음이 왔을 때
                else if initial.contains(buffer[i]) {
                    AutomataInfo.finish.append(neuter[AutomataInfo.Index.neuter])
                    AutomataInfo.Flag.neuter = 0
                    AutomataInfo.Index.neuter = -1
                    continue
                }
                i += 1
                continue

            } else if AutomataInfo.Flag.initial == 1, AutomataInfo.Flag.neuter == 0, AutomataInfo.Flag.final == 0 {
                // 초성이 있는 상태에서 자음이 왔을 때
                if initial.contains(buffer[i]) {
                    // 기존에 있던 초성을 AutomataInfo.finish에 append
                    AutomataInfo.finish.append(initial[AutomataInfo.Index.initial])
                    // 이것을 AutomataInfo.Index.initial에 할당
                    AutomataInfo.Index.initial = initial.firstIndex(of: buffer[i]) ?? -1
                    i += 1
                    continue
                } else if neuter.contains(buffer[i]) {
                    AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
                    AutomataInfo.Flag.neuter = 1
                    i += 1
                    continue
                }
            } else if AutomataInfo.Flag.initial == 1, AutomataInfo.Flag.neuter == 1, AutomataInfo.Flag.final == 0 {
                // 종성으로 모음이 왔을 때
                if neuter.contains(buffer[i]) {
                    // 기존에 완성되었던 것들 조합해서 AutomataInfo.finish에 append (모음끼리 합쳐질 수 없을 때)
                    if !neuterForSearch.contains(neuter[AutomataInfo.Index.neuter] + buffer[i]) {
                        let makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28
                        AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                        AutomataInfo.Index.neuter = neuter.firstIndex(of: buffer[i]) ?? -1
                        // 글자가 다시 시작될 수 있도록 전부 초기화
                        AutomataInfo.Flag.initial = 0
                        AutomataInfo.Flag.final = 0
                        AutomataInfo.Index.initial = -1
                        AutomataInfo.Index.final = -1
                    } else {
                        AutomataInfo.Index.neuter = neuterForSearch.firstIndex(of: neuter[AutomataInfo.Index.neuter] + buffer[i]) ?? -1
                    }
                    
                    i += 1
                    continue
                    // 종성으로 자음이 왔을 때
                } else if initial.contains(buffer[i]) {
                    if final.contains(buffer[i]) {
                        AutomataInfo.Index.final = final.firstIndex(of: buffer[i]) ?? -1
                        AutomataInfo.Flag.final = 1
                    } else {
                        let makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28
                        AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                        
                        AutomataInfo.Flag.initial = 0
                        AutomataInfo.Index.initial = -1
                        AutomataInfo.Flag.neuter = 0
                        AutomataInfo.Index.neuter = -1
                        continue
                    }
                    i += 1
                    continue
                }
            } else if AutomataInfo.Flag.initial == 1, AutomataInfo.Flag.neuter == 1, AutomataInfo.Flag.final == 1, AutomataInfo.Flag.secondFinal == 0 {
                // 자음이 또 왔을 때 기존의 종성이랑 합쳐질 수 있으면
                if final.contains(final[AutomataInfo.Index.final] + buffer[i]) {
                    AutomataInfo.Index.secondFinal = final.firstIndex(of: buffer[i]) ?? -1 //
                    AutomataInfo.Flag.secondFinal = 1
                    i += 1
                    continue
                }
                // 자음이 또 왔을 때 기존의 종성과 함쳐질 수 없으면
                else if initial.contains(buffer[i]), !final.contains(final[AutomataInfo.Index.final] + buffer[i]) {
                    // 기존에 완성된 글자 append
                    let makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28 + AutomataInfo.Index.final
                    AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                    // AutomataInfo.Index.initial에 value 저장
                    AutomataInfo.Index.initial = initial.firstIndex(of: buffer[i]) ?? -1
                    AutomataInfo.Flag.initial = 1
                    
                    AutomataInfo.Flag.neuter = 0
                    AutomataInfo.Index.neuter = -1
                    AutomataInfo.Flag.final = 0
                    AutomataInfo.Index.final = -1
                    i += 1
                    continue
                }
                // 모음이 왔을 때
                else if neuter.contains(buffer[i]) {
                    // 종성을 제외한 기존 글자 append
                    let makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28
                    AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                    // 종성 글자를 초성으로 변경, value를 모음 index에 저장
                    AutomataInfo.Index.initial = initial.firstIndex(of: final[AutomataInfo.Index.final]) ?? -1
                    
                    AutomataInfo.Flag.initial = 1
                    
                    // 나머지는 초기화
                    AutomataInfo.Flag.neuter = 0
                    AutomataInfo.Index.neuter = -1
                    AutomataInfo.Flag.final = 0
                    AutomataInfo.Index.final = -1
                    continue
                }
                // 종성에 ㄴㅈ 이런게 있을 때
            } else if AutomataInfo.Flag.secondFinal == 1 {
                // 자음이 왔을 때
                if initial.contains(buffer[i]) {
                    // ㄴ, ㅈ 합쳐서 새로운 인덱스로 넣고
                    AutomataInfo.Index.final = final.firstIndex(of: final[AutomataInfo.Index.final] + final[AutomataInfo.Index.secondFinal]) ?? -1
                    // 기존에 완성된거 출력
                    let makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28 + AutomataInfo.Index.final
                    AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                    
                    initInfo()
                    continue
                }
                // 모음이 왔을 때
                else if neuter.contains(buffer[i]) {
                    // 종성을 ㄴ으로 선택하고 앞에 글자 완성시킨다음 append
                    let makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28 + AutomataInfo.Index.final
                    AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
                    // ㅈ 은 AutomataInfo.Index.initial에 할당
                    AutomataInfo.Index.initial = initial.firstIndex(of: final[AutomataInfo.Index.secondFinal]) ?? -1
                    AutomataInfo.Flag.initial = 1
                    
                    AutomataInfo.Flag.neuter = 0
                    AutomataInfo.Index.neuter = -1
                    AutomataInfo.Flag.final = 0
                    AutomataInfo.Index.final = -1
                    AutomataInfo.Flag.secondFinal = 0
                    AutomataInfo.Index.secondFinal = -1
                    continue
                }
            }
        }
        
        cleanUpRest()
        return AutomataInfo.finish
    }
    
    func cleanUpRest() {
        // 찌꺼기 처리
        var makeWord : Int = 0
        // 초성, 중성, 종성 있을 때
        if AutomataInfo.Flag.initial == 0, AutomataInfo.Flag.neuter == 1 {
            AutomataInfo.finish.append(neuter[AutomataInfo.Index.neuter])
        }
        if AutomataInfo.Index.secondFinal != -1 {
            AutomataInfo.Index.final = final.firstIndex(of: final[AutomataInfo.Index.final] + final[AutomataInfo.Index.secondFinal]) ?? -1
        }
        if AutomataInfo.Index.initial != -1, AutomataInfo.Index.neuter != -1, AutomataInfo.Index.final != -1 {
            makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28 + AutomataInfo.Index.final
            AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
            // 초성, 중성 있을 때
        } else if AutomataInfo.Index.initial != -1, AutomataInfo.Index.neuter != -1 {
            makeWord = 44032 + AutomataInfo.Index.initial * 588 + AutomataInfo.Index.neuter * 28
            AutomataInfo.finish.append(String(UnicodeScalar(makeWord)!))
            // 초성만 있을 때
        } else if AutomataInfo.Index.initial != -1 {
            AutomataInfo.finish.append(initial[AutomataInfo.Index.initial])
        }
    }
    
    func erase() {
        if buffer.isEmpty == false {
            buffer.removeLast()
        }
    }
}
