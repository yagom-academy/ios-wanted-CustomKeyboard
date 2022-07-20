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
        "ㅣ","up","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "지움","스페이스","엔터"
    ]

    let doubleConsonant = [
        "ㅃ","ㅉ","ㄸ","ㄲ","ㅆ","ㅛ","ㅕ","ㅑ","ㅒ",
        "ㅖ","ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ",
        "ㅣ","up","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ",
        "지움","스페이스","엔터"
    ]
    
    @Published var isShift : Int = 0
    @Published var buffer : [String] = []
    @Published var count : Int = 0
        
    func processKeyboardInput(_ index : Int) {
        // Save in buffer
        if isShift == 0 {
            if consonant[index] != "지움", consonant[index] != "up", consonant[index] != "엔터" {
                if consonant[index] == "스페이스" {
                    buffer.append(" ")
                } else {
                    buffer.append(consonant[index])
                }
            }
        } else {
            if doubleConsonant[index] != "지움", doubleConsonant[index] != "up", doubleConsonant[index] != "엔터" {
                if doubleConsonant[index] == "스페이스" {
                    buffer.append(" ")
                } else {
                    buffer.append(doubleConsonant[index])
                }
            }
        }
        
        print("buffer : \(buffer)")
        if consonant[index] == "지움" || doubleConsonant[index] == "지움" {
            erase()
        } else if consonant[index] == "up" || doubleConsonant[index] == "up" {
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
    func automata() -> [String] {
        
        // 라벨에 표시할 글자
        var finish : [String] = []
        
        // 초기화 (유무)
        var initialFlag = 0
        var neuterFlag = 0
        var finalFlag = 0
        var secondFinalFlag = 0
        
        // 초기화 (Index)
        var initialIndex = -1
        var neuterIndex = -1
        var finalIndex = -1
        var secondFinalIndex = -1
        
        var i = 0
        while i < buffer.count {
            // space
            if buffer[i] == " " {
                var makeWord : Int = 0
                // 초성, 중성, 종성 있을 때
                if initialIndex != -1, neuterIndex != -1, finalIndex != -1 {
                    makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // 초성, 중성 있을 때
                } else if initialIndex != -1, neuterIndex != -1 {
                    makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // 초성만 있을 때
                } else if initialIndex != -1 {
                    finish.append(initial[initialIndex])
                }
                finish.append(" ")
                
                // 초기화
                initialFlag = 0
                neuterFlag = 0
                finalFlag = 0
                secondFinalFlag = 0
                
                initialIndex = -1
                neuterIndex = -1
                finalIndex = -1
                secondFinalIndex = -1
                i += 1
                continue
            }
            
            // 글자의 시작일 때
            if initialFlag == 0, neuterFlag == 0 {
                // 처음에 모음이 왔을 때
                if neuter.contains(buffer[i]) {
                    // 다음 모음이랑 합쳐질 수 없다면
                    neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                    neuterFlag = 1
                    i += 1
                    continue
                    // 처음에 자음이 왔을 때
                } else if initial.contains(buffer[i]) {
                    initialIndex = initial.firstIndex(of: buffer[i]) ?? -1
                    initialFlag = 1
                    i += 1
                    continue
                }
            } else if initialFlag == 0, neuterFlag == 1 {
                // 다음에 모음이 왔을 때 합쳐질 수 잇다면
                if neuterForSearch.contains(neuter[neuterIndex] + buffer[i]) {
                    finish.append(neuter[neuterForSearch.firstIndex(of: neuter[neuterIndex] + buffer[i]) ?? -1])
                    neuterFlag = 0
                    neuterIndex = -1
                }
                // 다음에 모음이 왔을 때 합쳐질 수 없다면
                else if !neuter.contains(neuter[neuterIndex] + buffer[i]), !initial.contains(buffer[i]) {
                    finish.append(neuter[neuterIndex])
                    neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                }
                // 다음에 자음이 왔을 때
                else if initial.contains(buffer[i]) {
                    finish.append(neuter[neuterIndex])
                    neuterFlag = 0
                    neuterIndex = -1
                    continue
                }
                i += 1
                continue

            } else if initialFlag == 1, neuterFlag == 0, finalFlag == 0 {
                // 초성이 있는 상태에서 자음이 왔을 때
                if initial.contains(buffer[i]) {
                    // 기존에 있던 초성을 finish에 append
                    finish.append(initial[initialIndex])
                    // 이것을 initialIndex에 할당
                    initialIndex = initial.firstIndex(of: buffer[i]) ?? -1
                    i += 1
                    continue
                } else if neuter.contains(buffer[i]) {
                    neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                    neuterFlag = 1
                    i += 1
                    continue
                }
            } else if initialFlag == 1, neuterFlag == 1, finalFlag == 0 {
                // 종성으로 모음이 왔을 때
                if neuter.contains(buffer[i]) {
                    // 기존에 완성되었던 것들 조합해서 finish에 append (모음끼리 합쳐질 수 없을 때)
                    if !neuterForSearch.contains(neuter[neuterIndex] + buffer[i]) {
                        let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                        finish.append(String(UnicodeScalar(makeWord)!))
                        neuterIndex = neuter.firstIndex(of: buffer[i]) ?? -1
                        // 글자가 다시 시작될 수 있도록 전부 초기화
                        initialFlag = 0
                        finalFlag = 0
                        initialIndex = -1
                        finalIndex = -1
                    } else {
                        neuterIndex = neuterForSearch.firstIndex(of: neuter[neuterIndex] + buffer[i]) ?? -1
                    }
                    
                    
                    i += 1
                    continue
                    // 종성으로 자음이 왔을 때
                } else if initial.contains(buffer[i]) {
                    if final.contains(buffer[i]) {
                        finalIndex = final.firstIndex(of: buffer[i]) ?? -1
                        finalFlag = 1
                    } else {
                        let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                        finish.append(String(UnicodeScalar(makeWord)!))
                        
                        initialFlag = 0
                        initialIndex = -1
                        neuterFlag = 0
                        neuterIndex = -1
                        continue
                    }
                    i += 1
                    continue
                }
            } else if initialFlag == 1, neuterFlag == 1, finalFlag == 1, secondFinalFlag == 0 {
                // 자음이 또 왔을 때 기존의 종성이랑 합쳐질 수 있으면
                if final.contains(final[finalIndex] + buffer[i]) {
                    secondFinalIndex = final.firstIndex(of: buffer[i]) ?? -1 //
                    secondFinalFlag = 1
                    i += 1
                    continue
                }
                // 자음이 또 왔을 때 기존의 종성과 함쳐질 수 없으면
                else if initial.contains(buffer[i]), !final.contains(final[finalIndex] + buffer[i]) {
                    // 기존에 완성된 글자 append
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // initialIndex에 value 저장
                    initialIndex = initial.firstIndex(of: buffer[i]) ?? -1
                    initialFlag = 1
                    
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    i += 1
                    continue
                }
                // 모음이 왔을 때
                else if neuter.contains(buffer[i]) {
                    // 종성을 제외한 기존 글자 append
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // 종성 글자를 초성으로 변경, value를 모음 index에 저장
                    initialIndex = initial.firstIndex(of: final[finalIndex]) ?? -1
                    
                    initialFlag = 1
                    
                    // 나머지는 초기화
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    continue
                }
                // 종성에 ㄴㅈ 이런게 있을 때
            } else if secondFinalFlag == 1 {
                // 자음이 왔을 때
                if initial.contains(buffer[i]) {
                    // ㄴ, ㅈ 합쳐서 새로운 인덱스로 넣고
                    finalIndex = final.firstIndex(of: final[finalIndex] + final[secondFinalIndex]) ?? -1
                    // 기존에 완성된거 출력
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    
                    initialFlag = 0
                    initialIndex = -1
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    secondFinalFlag = 0
                    secondFinalIndex = -1
                    continue
                }
                // 모음이 왔을 때
                else if neuter.contains(buffer[i]) {
                    // 종성을 ㄴ으로 선택하고 앞에 글자 완성시킨다음 append
                    let makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
                    finish.append(String(UnicodeScalar(makeWord)!))
                    // ㅈ 은 initialIndex에 할당
                    initialIndex = initial.firstIndex(of: final[secondFinalIndex]) ?? -1
                    initialFlag = 1
                    
                    neuterFlag = 0
                    neuterIndex = -1
                    finalFlag = 0
                    finalIndex = -1
                    secondFinalFlag = 0
                    secondFinalIndex = -1
                    continue
                }
            }
        }
        
        // 찌꺼기 처리
        var makeWord : Int = 0
        // 초성, 중성, 종성 있을 때
        if initialFlag == 0, neuterFlag == 1 {
            finish.append(neuter[neuterIndex])
        }
        if secondFinalIndex != -1 {
            finalIndex = final.firstIndex(of: final[finalIndex] + final[secondFinalIndex]) ?? -1
        }
        if initialIndex != -1, neuterIndex != -1, finalIndex != -1 {
            makeWord = 44032 + initialIndex * 588 + neuterIndex * 28 + finalIndex
            finish.append(String(UnicodeScalar(makeWord)!))
            // 초성, 중성 있을 때
        } else if initialIndex != -1, neuterIndex != -1 {
            makeWord = 44032 + initialIndex * 588 + neuterIndex * 28
            finish.append(String(UnicodeScalar(makeWord)!))
            // 초성만 있을 때
        } else if initialIndex != -1 {
            finish.append(initial[initialIndex])
        }
        
        print(finish)
        return finish
    }
    
    func erase() {
        if buffer.isEmpty == false {
            buffer.removeLast()
        }
    }
}
