//
//  KeyboardMaker.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/13.
//

/*
 지금 이루어 지고 있는 프로세스
 1. text 하나 들어옴
 2. keyboardMaker의 상태에 따라서 text가 들어갈 자리가 달라짐
 
 
 
 */








import Foundation

struct KeyboardData {
    
    var hangul: String = ""
    var unicode: Int = 0
    var bornState: KeyboardMaker.HangulState = .empty
    
    init(char: String, state: KeyboardMaker.HangulState) {
        self.hangul = char
        self.unicode = convertStr2Unicode(char: char)
        self.bornState = state
    }
    
    init(uni: Int, state: KeyboardMaker.HangulState) {
        self.unicode = uni
        self.hangul = convertUni2Str(uni: uni)
        self.bornState = state
    }
    
    init(char: String, uni: Int, lastState: KeyboardMaker.HangulState) {
        self.hangul = char
        self.unicode = uni
        self.bornState = lastState
    }
    
    private func convertUni2Str(uni: Int) -> String {
        if let unicodeScalar = UnicodeScalar(uni) {
            return String(unicodeScalar)
        }
        return ""
    }
    
    private func convertStr2Unicode(char: String) -> Int {
        if let unicodeScalar = UnicodeScalar(char) {
            return Int(unicodeScalar.value)
        }
        return 0
    }
    
}

class KeyboardMaker {
    
    struct Status {
        var currentState: HangulState
        var isCompleted: Bool
        var alphaRepository: [KeyboardData]
    }
    
    enum HangulState: Int {
        case empty = 0
        case cho = 1
        case doubleCho = 2
        case jung = 3
        case doubleJung = 4
        case jong = 5
        case doubleJong = 6
    }
    
    typealias CombineBuffer = (cho: String, jung: String, jong: String)
    
    private var isSpacePressed = false
    
    private var isEditing = true
    
    private var combineBuffer: CombineBuffer = ("", "", "") // 현재 쓰여지고 있는 음소를 모아서 조합한 후 방출, 비워지는 배열
    
    private var processingBuffer = Status(currentState: .empty, isCompleted: false, alphaRepository: [])
    
    private var releaseTextField = ""
    
    public func confirmEnterPressed(input: String) -> Bool {
        return convertStr2Unicode(char: input) == SpecialCharSet.enter
    }
    
    public func putHangul(input: String) -> String {
        
        let inputData = KeyboardData(char: input, state: .empty)
        
        guard inputData.hangul != " " else {
            let spaceKeyboardData = KeyboardData(char: " ", state: .empty)
            processingBuffer.alphaRepository.append(spaceKeyboardData)
            processingBuffer.isCompleted = false
            combineBuffer = ("","","")
            isEditing = false
            releaseTextField+=" "
            return processingBuffer.alphaRepository.map{$0.hangul}.reduce(into: ""){$0+=$1}
        }
        
        isEditing = true
        
        switch processingBuffer.currentState {
        case .empty:
            processingBuffer = emptyStage(status: processingBuffer, input: inputData)
        case .cho:
            processingBuffer = singleChoStage(status: processingBuffer, input: inputData)
        case .doubleCho:
            processingBuffer = doubleChoStage(status: processingBuffer, input: inputData)
        case .jung:
            processingBuffer = singleJungStage(status: processingBuffer, input: inputData)
        case .doubleJung:
            processingBuffer = doubleJungStage(status: processingBuffer, input: inputData)
        case .jong:
            processingBuffer = singleJongStage(status: processingBuffer, input: inputData)
        case .doubleJong:
            processingBuffer = doubleJongStage(status: processingBuffer, input: inputData)
        }
        
        if !processingBuffer.alphaRepository.isEmpty && processingBuffer.alphaRepository.last!.bornState == .jong && combineBuffer.jung != "" && combineBuffer.jong == "" { // 종성일때 - is로 바꿔도 됨
            
            let decomposedHangul = decomposeHangul(hangul: processingBuffer.alphaRepository.last!, lastState: .jong)
            let newBuffer: CombineBuffer = (decomposedHangul[0], decomposedHangul[1], "")
            let newHangul = combineHangul(buffer: newBuffer, lastState: .jung)
            
            processingBuffer.alphaRepository[processingBuffer.alphaRepository.count - 1] = newHangul
            
        } else if !processingBuffer.alphaRepository.isEmpty && processingBuffer.alphaRepository.last!.bornState == .doubleJong && combineBuffer.jung != "" && combineBuffer.jong == "" { // 조합종성일때 - is로 바꿔도 됨
            
            let decomposedHangul = decomposeHangul(hangul: processingBuffer.alphaRepository.last!, lastState: .doubleJong)
            let newBuffer: CombineBuffer = (decomposedHangul[0], decomposedHangul[1], decomposedHangul[2])
            let newHangul = combineHangul(buffer: newBuffer, lastState: .jong)
            
            processingBuffer.alphaRepository[processingBuffer.alphaRepository.count - 1] = newHangul
        }
        
        if processingBuffer.isCompleted {
            
            let combinedHagul = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
            
            processingBuffer.alphaRepository.append(combinedHagul)
            processingBuffer.isCompleted = false
            
            return processingBuffer.alphaRepository.map{$0.hangul}.reduce(into: ""){$0+=$1}
        }
        
        if processingBuffer.alphaRepository.count <= 1 {
            
            if processingBuffer.alphaRepository.isEmpty {
                processingBuffer.alphaRepository.append(combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState))
            } else {
                processingBuffer.alphaRepository[0] = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
            }
            
        } else if processingBuffer.alphaRepository.count > 1 {
            
                processingBuffer.alphaRepository[processingBuffer.alphaRepository.count - 1] = combineHangul(
                    buffer: combineBuffer,
                    lastState: processingBuffer.currentState
                )
                
        }
        
        return processingBuffer.alphaRepository.map{$0.hangul}.reduce(into: ""){$0+=$1}
    }
    
    // MARK: - combineHangul
   
    
    func combineHangul(buffer: CombineBuffer, lastState: HangulState) -> KeyboardData { // 글자 조합해서 방
        if lastState == .cho && buffer.jung == "" && buffer.jong == "" {
            return KeyboardData(char: buffer.cho, state: lastState)
        } else if lastState == .doubleCho && buffer.jung == "" && buffer.jong == "" {
            return KeyboardData(char: buffer.cho, state: lastState)
        } else if (lastState == .jung || lastState == .doubleJung) && buffer.cho == "" && buffer.jong == "" {
            return KeyboardData(char: buffer.jung, state: lastState)
        }
        
        guard buffer.cho != "" && buffer.jung != "" else {
            return KeyboardData(char: "", state: lastState)
        }
        
        //TODO: - 한글set에 해당 unicode가 없을경우 예외처리 해야함
        let cho = HangulSet.chos.firstIndex(of: buffer.cho) ?? 0
        let jung = HangulSet.jungs.firstIndex(of: buffer.jung) ?? 0
        let jong = HangulSet.jongs.firstIndex(of: buffer.jong) ?? 0
        
        let uni2Str = convertUni2Str(uni: 44032 + cho * 28 * 21 + 28 * jung + jong)
        let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
        let hangul = KeyboardData(char: uni2Str, uni: uni, lastState: lastState)

        return hangul
    }
    
    func decomposeHangul(hangul: KeyboardData, lastState: HangulState) -> [String] {
        
        let hangulUnicode = hangul.unicode
        
        let choIndex = (hangulUnicode - 0xAC00) / 588
        let cho = HangulSet.chos[choIndex]
        
        let removeCho = (hangulUnicode - 0xAC00) % 588
        let jungIndex = removeCho / 28
        let jung = HangulSet.jungs[jungIndex]
        
        let jongIndex = (hangulUnicode - 0xAC00) % 28
        let jong = decomposeJongs(str: HangulSet.jongs[jongIndex])
        
        return [cho, jung] + jong
    }
    
    func decomposeJongs(str: String) -> [String] {
        guard let idx = HangulSet.doubleJongs.firstIndex(of: str) else {
            return [str]
        }
        return [HangulSet.checkingJongs[idx].0, HangulSet.checkingJongs[idx].1]
    }
    
    func convertStr2Unicode(char: String) -> Int {
        if let unicodeScalar = UnicodeScalar(char) {
            return Int(unicodeScalar.value)
        }
        return 0
    }
    
    func convertUni2Str(uni: Int) -> String {
        if let unicodeScalar = UnicodeScalar(uni) {
            return String(unicodeScalar)
        }
        return ""
    }
    
    func canMakeDoubleCho(onProcessing: String, input: String) -> Bool { // 쌍자음 체크
        if HangulSet.checkingDoubleChos.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    
    func canMakeDoubleJung(onProcessing: String, input: String) -> Bool { // 모음 조합 확인
        if HangulSet.checkingDoubleJungs.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    func canMakeTripleJung(onProcessing: String, input: String) -> Bool { // 삼중 모음 조합 확인
        if HangulSet.checkingTripleJungs.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    
    func canMakeDoubleJong(onProcessing: String, input: String) -> Bool { // 종성 조합 확인
        if HangulSet.checkingJongs.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    
    func combineSingleToDouble(input: Int) -> Int {
        return input+1
    }
    
    func combineSingleJungToDouble(onProcessing: String, input: String) -> String {
        let index = HangulSet.checkingDoubleJungs.firstIndex{$0 == (onProcessing, input)} ?? 0
        return HangulSet.doubleJungs[index]
    }
    func combineTripleJungToDouble(onProcessing: String, input: String) -> String {
        let index = HangulSet.checkingTripleJungs.firstIndex{$0 == (onProcessing, input)} ?? 0
        return HangulSet.tripleJungs[index]
    }
    
    func combineSingleJongToDouble(onProcessing: String, input: String) -> String {
        let index = HangulSet.checkingJongs.firstIndex{ $0 == (onProcessing, input)} ?? 0
        return HangulSet.doubleJongs[index]
    }
    
    
    
    // MARK: - stage
    
    func emptyStage(status: Status, input: KeyboardData) -> Status {
        
        combineBuffer = ("","","")
        var currentStatus = status
        var currentHangul = input
        currentHangul.bornState = .empty
        
        if HangulSet.chos.contains(input.hangul) { // 초성
            if HangulSet.doubleChos.contains(currentHangul.hangul) { // 쌍자음
                
                combineBuffer.cho = currentHangul.hangul
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = false
                
                return currentStatus
            }
            
            combineBuffer.cho = currentHangul.hangul
            currentStatus.currentState = .cho
            currentStatus.isCompleted = false
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentHangul.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentHangul.hangul) { // 이중 모음
                
                combineBuffer.jung = currentHangul.hangul
                currentStatus.isCompleted = true
                currentStatus.currentState = .doubleJung
                
                return currentStatus
            }
            
            combineBuffer.jung = currentHangul.hangul
            currentStatus.isCompleted = true
            currentStatus.currentState = .jung

            return currentStatus
            
        } else if currentHangul.unicode == SpecialCharSet.delete {
            
            if currentStatus.alphaRepository.count == 0 {
                currentStatus.isCompleted = false
                currentStatus.currentState = .empty
            }
            
            return currentStatus
            
        }
        
        return currentStatus
    }
    
    //MARK: - 초성 1 스테이지
    func singleChoStage(status: Status, input: KeyboardData) -> Status { // 초성 자음 하나가 들어온 상태
        
        var currentStatus = status
        var currentHangul = input
        currentHangul.bornState = .cho
        
        if HangulSet.chos.contains(currentHangul.hangul) { // 초성
            if HangulSet.doubleChos.contains(currentHangul.hangul) { // 쌍자음 ex) ㄱㄲ
                
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer.cho = currentHangul.hangul
                
                return currentStatus
            }
            
            // 초성 조합
            // 자음이 하나 있는 상태에서 자음이 하나 더 들어오면 쌍자음을 만들수 있는지 확인 후 있으면 만들어 combineBuffer에 넣어 내보낼 준비 ex) ㄲ
            
            if canMakeDoubleCho(onProcessing: status.alphaRepository.last!.hangul, input: currentHangul.hangul) {
                let combinedChar = combineSingleToDouble(input: convertStr2Unicode(char: currentHangul.hangul))
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = false
                combineBuffer.cho = convertUni2Str(uni: combinedChar)
                return currentStatus
                
            } else { // 아닐경우 combineBuffer를 비우고 초성 상태로 돌린다. ex) ㄱㅂ
                
                currentStatus.currentState = .cho
                currentStatus.isCompleted = true
                combineBuffer.cho = currentHangul.hangul
                
                return currentStatus
            }
            
            //
        } else if HangulSet.jungs.contains(currentHangul.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentHangul.hangul) { // 이중 모음
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer.jung = currentHangul.hangul
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = false
            combineBuffer.jung = currentHangul.hangul
            
            return currentStatus
            
        } else if currentHangul.unicode == SpecialCharSet.delete {
            
            currentStatus.isCompleted = false
            
            if processingBuffer.alphaRepository.count > 1 {
                currentStatus.currentState = processingBuffer.alphaRepository[processingBuffer.alphaRepository.count - 2].bornState
            } else {
                currentStatus.currentState = .empty
            }
            
            combineBuffer = ("","","")
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    //MARK: - 초성 2 스테이지
    func doubleChoStage(status: Status, input: KeyboardData) -> Status { // 초성 쌍자음이 들어온 상태
        
        var currentStatus = status
        var currentHangul = input
        currentHangul.bornState = .doubleCho
        
        if HangulSet.chos.contains(currentHangul.hangul) { // 인풋이 초성
            if HangulSet.doubleChos.contains(currentHangul.hangul) { // 쌍자음 ex) ㄲㄲ
                
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer.cho = currentHangul.hangul
                
                return currentStatus
            }
            
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer.cho = currentHangul.hangul
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentHangul.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentHangul.hangul) { // 이중 모음
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer.jung = currentHangul.hangul
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = false
            combineBuffer.jung = currentHangul.hangul
            
            return currentStatus
            
        } else if currentHangul.unicode == SpecialCharSet.delete {
            
            currentStatus.isCompleted = false
            
            if let lastHangul = processingBuffer.alphaRepository.last {
                
                if HangulSet.doubleChos.contains(lastHangul.hangul) {
                    
                    let newHangul = KeyboardData(uni: lastHangul.unicode - 1, state: .cho)
                    combineBuffer = (newHangul.hangul,"","")
                    currentStatus.currentState = newHangul.bornState
                }
                
                return currentStatus
            }
            
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    //MARK: - 중성 1 스테이지
    func singleJungStage(status: Status, input: KeyboardData) -> Status { // 중성인데 input이 들어오는 경우
        
        var currentStatus = status
        var currentHangul = input
        currentHangul.bornState = .jung
        
        if HangulSet.jungs.contains(currentHangul.hangul) { // 중성이 들어오는 경우 조합이 되는지 확인 후 되면 조합 후 조합중성 stage로 넘기고 아니라면 글자 완성.
            if canMakeDoubleJung(onProcessing: combineBuffer.jung, input: currentHangul.hangul) {
                
                let combinedStr = combineSingleJungToDouble(onProcessing: combineBuffer.jung, input: currentHangul.hangul)
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer.jung = combinedStr
                
                return currentStatus
            }
            combineBuffer = ("","","")
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer.jung = currentHangul.hangul
            
            return currentStatus
            
        } else if combineBuffer.cho != "" { // 초성이 이미 있다면 초중 완성. 즉, 종성을 받아 조합 되는지 여부 확인
            
            // TODO: - 단일 종성배열로 리팩토링때 다시 한번 분기 가능함. - 스토리텔링
            if HangulSet.jongs.contains(currentHangul.hangul) { // 종성이 쌍자음일 경우와 아닐 경우의 넘기는 stage 차이 분기
                if HangulSet.doubleJongs.contains(currentHangul.hangul) {
                    
                    currentStatus.currentState = .doubleJong
                    // MARK: - 이 부분에서 true를 넘길경우 중복으로 쓰여진다.
                    currentStatus.isCompleted = false
                    combineBuffer.jong = currentHangul.hangul
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .jong
                currentStatus.isCompleted = false
                combineBuffer.jong = currentHangul.hangul
                
                return currentStatus
            }
            
        } else if HangulSet.chos.contains(currentHangul.hangul) { //버퍼에 초성이 없으므로 초성인 경우 -> 이 시점에서 글자를 완성 시키고 combineBuffer를 비워야 함.
            // 인풋이 초성
            if HangulSet.doubleChos.contains(currentHangul.hangul) {
                
                combineBuffer = ("","","")
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer.cho = currentHangul.hangul
                
                return currentStatus
            }
            
            combineBuffer = ("","","")
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer.cho = currentHangul.hangul
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func doubleJungStage(status: Status, input: KeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleJung
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성이 들어오는 경우 조합이 되는지 확인 후 되면 조합 후 조합중성 stage로 넘기고 아니라면 글자 완성.
            
            if canMakeTripleJung(onProcessing: combineBuffer.jung, input: currentKeyboardData.hangul) {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = .doubleJong
                let newJung = combineTripleJungToDouble(onProcessing: combineBuffer.jung, input: currentKeyboardData.hangul)
                combineBuffer.jung = newJung
                
                return currentStatus
                
            } else if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                
                combineBuffer = ("","","")
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = true
                combineBuffer.jung = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            combineBuffer = ("","","")
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer.jung = currentKeyboardData.hangul
            
            return currentStatus
            
        } else if combineBuffer.cho != "" {
            // TODO: - 단일 종성배열로 리팩토링때 다시 한번 분기 가능함. - 스토리텔링
            if HangulSet.jongs.contains(currentKeyboardData.hangul) { // 종성이 쌍자음일 경우와 아닐 경우의 넘기는 stage 차이 분기
                if HangulSet.doubleJongs.contains(currentKeyboardData.hangul) {
                    
                    currentStatus.currentState = .doubleJong
                    // MARK: - 이 부분에서 true를 넘길경우 중복으로 쓰여진다.
                    currentStatus.isCompleted = false
                    combineBuffer.jong = currentKeyboardData.hangul
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .jong
                currentStatus.isCompleted = false
                combineBuffer.jong = currentKeyboardData.hangul
                
                return currentStatus
            }
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) { //버퍼에 초성이 없으므로 초성인 경우 -> 이 시점에서 글자를 완성 시키고 combineBuffer를 비워야 함.
            // 인풋이 초성
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                combineBuffer = ("","","")
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer.cho = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            combineBuffer = ("","","")
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer.cho = currentKeyboardData.hangul
            
            return currentStatus
        }
        
        
        return currentStatus
    }
    
    func singleJongStage(status: Status, input: KeyboardData) -> Status {
        
        var currentStatus = status
        var currentHangul = input
        currentHangul.bornState = .jong
        
        if HangulSet.jungs.contains(currentHangul.hangul) { // 중성이 들어오는 경우 조합
            // repo의 배열 마지막을 분해해서 그 분해한 마지막 배열을 가져온 다음 분해한 것의 세번째 까지만 repo의 마지막에서 두번째 배열에 넣고 분해한것의 마지막 것은 지금 들어온 str과 합쳐서 마지막 배열에 붙혀줌
            if HangulSet.doubleJungs.contains(currentHangul.hangul) {
                
                
                //중성이 들어오는 경우 초성을 새로 들어온 종성으로 바꾸고 종성을 비운뒤 방출한다.
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = true
                combineBuffer.cho = combineBuffer.jong
                combineBuffer.jung = currentHangul.hangul
                combineBuffer.jong = ""
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer.cho = combineBuffer.jong
            combineBuffer.jung = currentHangul.hangul
            combineBuffer.jong = ""
            
            return currentStatus
            
        } else if HangulSet.chos.contains(currentHangul.hangul) { // 종성이 있는데 자음이 들어올 때
            // 우선 들어온 자음과 기존 자음이 조합 되는지 확인
            if canMakeDoubleJong(onProcessing: combineBuffer.jong, input: currentHangul.hangul) { // 종성 조합 가능
                currentStatus.currentState = .doubleJong
                currentStatus.isCompleted = false
                let combinedDoubleJong = combineSingleJongToDouble(onProcessing: combineBuffer.jong, input: currentHangul.hangul)
                combineBuffer.jong = combinedDoubleJong
                
                return currentStatus
            }
            
            // 조합이 안된다면 초성으로 넘긴다.
            combineBuffer = ("","","")
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer.cho = currentHangul.hangul
            
            return currentStatus
            
        }
        
        return currentStatus
    }
    
    func doubleJongStage(status: Status, input: KeyboardData) -> Status {
        
        var currentStatus = status
        var currentHangul = input
        currentHangul.bornState = .doubleJong
        
        if HangulSet.chos.contains(input.hangul) { // 초성
            if HangulSet.doubleChos.contains(currentHangul.hangul) { // 쌍자음
                
                combineBuffer = ("","","")
                combineBuffer.cho = currentHangul.hangul
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                
                return currentStatus
            }
            
            combineBuffer = ("","","")
            combineBuffer.cho = currentHangul.hangul
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentHangul.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentHangul.hangul) { // 이중 모음
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = true
                combineBuffer.cho = combineBuffer.jong
                combineBuffer.jung = currentHangul.hangul
                combineBuffer.jong = ""
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer.cho = combineBuffer.jong
            combineBuffer.jung = currentHangul.hangul
            combineBuffer.jong = ""
            
            return currentStatus
        }
        
        return currentStatus
    }
    
}
