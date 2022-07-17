//
//  HangulAutomata.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/14.
//

//오토마타의 상태를 정의
enum HangulStatus{
    case start //s0
    case chosung //s1
    case joongsung, dJoongsung //s2,s3
    case jongsung, dJongsung //s4, s5
    case endOne, endTwo //s6,s7
}

//입력된 키의 종류 판별 정의
enum HangulCHKind{
    case consonant //자음
    case vowel  //모음
}

//키 입력마다 쌓이는 입력 스택 정의
struct InpStack{
    var curhanst: HangulStatus //상태
    var key : UInt32 //방금 입력된 키 코드
    var charCode : String //조합된 코드
    var chKind : HangulCHKind // 입력된 키가 자음인지 모임인지
}

import Foundation

class HangulAutomata{
    
    var buffer : [String] = []
    
    var cursor : Int = 0
    
    //input스택 해당 스택이 현재 조합중인 한글을 보여주는 역할을 함
    var inpStack : [InpStack] = []
    var inpSP : Int = 0
    
    var outStack : [String] = []
    var outSp : Int = 0
    
    var currentHangulState : HangulStatus?
    
    var chKind : HangulCHKind!
    
    var charCode : String!
    var oldKey : UInt32!
    var oldChKind : HangulCHKind?
    var keyCode : UInt32!
    
    var chosungTable : [String] = ["ㄱ","ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    var joongsungTable : [String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    
    var jongsungTable : [String] = [" ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ","ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    var dJoongTable : [[String]] = [
        ["ㅗ","ㅏ","ㅘ"],
        ["ㅗ","ㅐ","ㅙ"],
        ["ㅗ","ㅣ","ㅚ"],
        ["ㅜ","ㅓ","ㅝ"],
        ["ㅜ","ㅔ","ㅞ"],
        ["ㅜ","ㅣ","ㅟ"],
        ["ㅡ","ㅣ","ㅢ"]
    ]
    
    var dJongTable : [[String]] = [
        ["ㄱ","ㅅ","ㄳ"],
        ["ㄴ","ㅈ","ㄵ"],
        ["ㄴ","ㅎ","ㄶ"],
        ["ㄹ","ㄱ","ㄺ"],
        ["ㄹ","ㅁ","ㄻ"],
        ["ㄹ","ㅂ","ㄼ"],
        ["ㄹ","ㅅ","ㄽ"],
        ["ㄹ","ㅌ","ㄾ"],
        ["ㄹ","ㅍ","ㄿ"],
        ["ㄹ","ㅎ","ㅀ"],
        ["ㅂ","ㅅ","ㅄ"]
    ]
    
    func joongsungPair()->Bool{
        for i in 0..<dJoongTable.count{
            if dJoongTable[i][0] == joongsungTable[Int(oldKey)] && dJoongTable[i][1] == joongsungTable[Int(keyCode)]{
                keyCode = UInt32(joongsungTable.firstIndex(of: dJoongTable[i][2])!)
                return true
            }
        }
        return false
    }
    
    func jongsungPair()->Bool{
        for i in 0..<dJongTable.count{
            if dJongTable[i][0] == jongsungTable[Int(oldKey)] && dJongTable[i][1] == chosungTable[Int(keyCode)]{
                keyCode = UInt32(jongsungTable.firstIndex(of: dJongTable[i][2])!)
                return true
            }
        }
        return false
    }
    
    func decompositionChosung(charCode : UInt32)->UInt32{
        let unicodeHangul = charCode-0xAC00
        let jongsung = (unicodeHangul) % 28
        let joongsung = ((unicodeHangul-jongsung)/28)%21
        let chosung = (((unicodeHangul-jongsung)/28)-joongsung)/21
        return chosung
    }
    
    func decompositionChosungJoongsung(charCode : UInt32)->UInt32{
        let unicodeHangul = charCode-0xAC00
        let jongsung = (unicodeHangul) % 28
        let joongsung = ((unicodeHangul-jongsung)/28)%21
        let chosung = (((unicodeHangul-jongsung)/28)-joongsung)/21
        return combinationHangul(chosung: chosung, joongsung: joongsung, jongsung: keyCode)
    }
    
    func combinationHangul(chosung : UInt32 = 0, joongsung : UInt32, jongsung : UInt32 = 0)->UInt32{
        return (((chosung*21)+joongsung)*28)+jongsung+0xAC00
    }
}

extension HangulAutomata{
    func hangulAutomata(key : String){
        var canBeJongsung : Bool = false
        if joongsungTable.contains(key){
            chKind = .vowel
            keyCode = UInt32(joongsungTable.firstIndex(of: key)!)
        }else{
            chKind = .consonant
            keyCode = UInt32(chosungTable.firstIndex(of: key)!)
            if !((key == "ㄸ") || (key == "ㅉ") || (key == "ㅃ")){
                canBeJongsung = true
            }
        }
        if currentHangulState != nil{
            oldKey = inpStack[inpSP-1].key
            oldChKind = inpStack[inpSP-1].chKind
        }else{
            currentHangulState = .start
            buffer.append("")
        }
        //MARK: - 오토마타 전이 알고리즘
        switch currentHangulState{
        case .start:
            if chKind == .consonant{
                currentHangulState = .chosung
            }else{
                currentHangulState = .jongsung
            }
            break
        case .chosung:
            if chKind == .vowel{
                currentHangulState = .joongsung
            }else{
                currentHangulState = .endOne
            }
            break
        case .joongsung:
            if canBeJongsung{
                currentHangulState = .jongsung
            }else if joongsungPair(){
                currentHangulState = .dJoongsung
            }else{
                currentHangulState = .endOne
            }
            break
        case .dJoongsung:
            if canBeJongsung{
                currentHangulState = .jongsung
            }else{
                currentHangulState = .endOne
            }
            break
        case .jongsung:
            if (chKind == .consonant) && jongsungPair(){
                currentHangulState = .dJongsung
            }else if chKind == .vowel{
                currentHangulState = .endTwo
            }else{
                currentHangulState = .endOne
            }
            break
        case .dJongsung:
            if chKind == .vowel{
                currentHangulState = .endTwo
            }else{
                currentHangulState = .endOne
            }
            break
        default:
            break
        }
        //MARK: - 오토마타 상태 별 작업 알고리즘
        switch currentHangulState{
        case .chosung:
            charCode = chosungTable[Int(keyCode)]
            break
        case .joongsung:
            charCode = String(Unicode.Scalar(combinationHangul(chosung: oldKey, joongsung: keyCode))!)
            break
        case .dJoongsung:
            let currentChosung = decompositionChosung(charCode: Unicode.Scalar(charCode)!.value)
            charCode = String(Unicode.Scalar(combinationHangul(chosung: currentChosung, joongsung: keyCode))! )
            break
        case .jongsung:
            if canBeJongsung{
                keyCode = UInt32(jongsungTable.firstIndex(of: key)!)
                let currentCharCode =  Unicode.Scalar(charCode)!.value
                charCode = String(Unicode.Scalar(decompositionChosungJoongsung(charCode: currentCharCode))!)
            }else{
                charCode = key
            }
            break
        case .dJongsung:
            let currentCharCode =  Unicode.Scalar(charCode)!.value
            charCode = String(Unicode.Scalar(decompositionChosungJoongsung(charCode: currentCharCode))!)
            keyCode = UInt32(jongsungTable.firstIndex(of: key)!)
            break
        case .endOne:
            //중성 -> 모음 입력시 이전에 입력한 키가 그대로 입력되는 문제
            if chKind == .consonant{
                charCode = chosungTable[Int(keyCode)]
                currentHangulState = .chosung
            }else{
                charCode = joongsungTable[Int(keyCode)]
                currentHangulState = .jongsung
            }
            
            buffer.append("")
            cursor += 1
            break
        case.endTwo:
            if oldChKind == .consonant{
                oldKey = UInt32(chosungTable.firstIndex(of: jongsungTable[Int(oldKey)])!)
                charCode =  String(Unicode.Scalar(combinationHangul(chosung: oldKey, joongsung: keyCode))!)
                currentHangulState = .joongsung
                buffer[cursor] = inpStack[inpSP-2].charCode
                buffer.append("")
                cursor += 1
            }else{
                // 모음 + 모음 일경우 뒤에 빈 배열 한칸 생성되는 문제 해결
                if !joongsungPair(){
                    cursor += 1
                    buffer.append("")
                }
                charCode = joongsungTable[Int(keyCode)]
                currentHangulState = nil
                currentHangulState = .jongsung
            }
            break
        default:
            break
        }
        inpStack.append(InpStack(curhanst: currentHangulState!, key: keyCode, charCode: String(Unicode.Scalar(charCode)!), chKind: chKind))
        inpSP += 1
        buffer[cursor] = charCode
    }
}
