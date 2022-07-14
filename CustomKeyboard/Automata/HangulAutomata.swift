//
//  HangulAutomata.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/14.
//

//오토마타의 상태를 정의
enum HangulStatus{
    case start //s0
    case chosung
    case joongsung, dJoongsung
    case jongsung, dJongsung
    case endOne, endTwo //s6,s7
}

//입력된 키의 종류 판별 정의
enum HangulCHKind{
    case consonant //자음
    case vowel  //모음
}

//키 입력마다 쌓이는 입력 스택 정의
struct InpStack{
    var curhanst: HangulStatus
    var key : Int
    var charCode : Int
}

import Foundation

class HangulAutomata{
    var inpStack : [InpStack] = []
    var inpSP : Int!
    
    var outStack : [Int] = []
    
    var currentHangulState : HangulStatus?
    
    var chKind : HangulCHKind!
    var canBeJongsung : Bool = false
    
    var charCode : Int!
    var oldKey : Int!
    var keyCode : Int!
    
    var vowelTable : [String] = [
        "ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ"
        ,"ㅖ","ㅗ","ㅛ","ㅜ","ㅠ","ㅡ","ㅣ"
    ]
    
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
    
    //겹모음을 이루는지 검사
    func joongsungPair()->Bool{
        for i in 0..<dJoongTable.count{
            if UnicodeScalar(dJoongTable[i][0])!.value == oldKey && UnicodeScalar(dJoongTable[i][1])!.value == keyCode{
                keyCode = Int(UnicodeScalar(dJoongTable[i][2])!.value)
                return true
            }
        }
        return false
    }
    
    //겹받침을 이루는지 검사
    func jongsungPair()->Bool{
        for i in 0..<dJongTable.count{
            if UnicodeScalar(dJongTable[i][0])!.value == oldKey && UnicodeScalar(dJongTable[i][1])!.value == keyCode{
                keyCode = Int(UnicodeScalar(dJongTable[i][2])!.value)
                return true
            }
        }
        return false
    }
}

extension HangulAutomata{
    func hangulAutomata(key : String){
        //입력된 값이 모음인지 자음인지 검사
        if vowelTable.contains(key){
            chKind = .vowel
        }else{
            chKind = .consonant
            //모음일시 종성으로 들어갈 수 있는지 판단
            if !((key == "ㄸ") || (key == "ㅉ") || (key == "ㅃ")){
                canBeJongsung = true
            }
        }
        if currentHangulState != nil{
            oldKey = inpStack[inpSP-1].key
        }else{
            currentHangulState = .start
            oldKey = 0
        }
        
        //현재 입력된 키
        keyCode = Int(UnicodeScalar(key)!.value)
        
        switch currentHangulState{
        case .start:
            if chKind == .consonant{
                currentHangulState = .chosung
            }else{
                currentHangulState = .joongsung
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
        
        switch currentHangulState{
        case .chosung:
            break
        case .joongsung:
            break
        case .dJoongsung:
            break
        case .jongsung:
            break
        case .dJongsung:
            break
        case .endOne:
            break
        case.endTwo:
            break
        default:
            break
        }
    }
}
