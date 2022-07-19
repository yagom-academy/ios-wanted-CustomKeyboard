//
//  KeyboardMaker.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/13.
//

import Foundation

class KeyboardMaker {
    
    struct Status {
        var currentState: HangulKeyboardData.HangulState
        var isCompleted: Bool
        var alphaRepository: [HangulKeyboardData]
    }
    
    typealias CombineBuffer = [String]
    
    private var isDoubleJong = false
    private var isJong = false
    private var isdeleting = false
    
    private var combineBuffer: CombineBuffer = [String](repeating: "", count: 3) // 현재 쓰여지고 있는 음소를 모아서 조합한 후 방출, 비워지는 배열
    private var processingBuffer = Status(currentState: .empty, isCompleted: false, alphaRepository: [])
    private var releaseTextField = [String]()
    
    private let hangulConverter = HangulKeyboardConverter()
    private let combineValidator = HangulCombineValidator()
    
    public func putKeyboardData(data inputData: HangulKeyboardData) -> [String] {
        
        guard inputData.hangul != " " else {
            
            let spaceKeyboardData = HangulKeyboardData(char: " ", state: processingBuffer.currentState)
            
            processingBuffer.alphaRepository.removeAll()
            processingBuffer.isCompleted = false
            processingBuffer.currentState = .empty
            
            combineBuffer = ["", "", ""]
            
            releaseTextField.append(spaceKeyboardData.hangul)
            
            return releaseTextField
        }
        
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
        
        if isdeleting && !releaseTextField.isEmpty && !processingBuffer.alphaRepository.isEmpty {
            
            if processingBuffer.alphaRepository.last!.hangul == releaseTextField.last! {
                
                processingBuffer.alphaRepository.removeLast()
                releaseTextField.removeLast()
                isdeleting = false
                
                if !releaseTextField.isEmpty {
                    let decomposedHangul = decomposeHangul(hangul: releaseTextField.last!, lastState: processingBuffer.currentState)
                    decomposedHangul.enumerated().forEach{ combineBuffer[$0.offset] = $0.element }
                }
                
                return releaseTextField
                
            } else {
                
                var decomposedHangul = decomposeHangul(hangul: releaseTextField.last!, lastState: processingBuffer.currentState)
                
                decomposedHangul = decomposedHangul.filter{$0 != " "}
                processingBuffer.alphaRepository.removeLast()
                decomposedHangul.removeLast()
                decomposedHangul.enumerated().forEach{ combineBuffer[$0.offset] = $0.element }
                
                let recombinedHangul = combineHangulForDelete(buffer: decomposedHangul, lastState: processingBuffer.currentState)
                
                releaseTextField[releaseTextField.count - 1] = recombinedHangul.hangul
                isdeleting = false
                
                return releaseTextField
            }
            
        } else if inputData.unicode == SpecialCharSet.delete && processingBuffer.alphaRepository.count == 0 {
            processingBuffer.currentState = .empty
            combineBuffer = ["", "", ""]
            if !releaseTextField.isEmpty {
                releaseTextField.removeLast()
            }
            return releaseTextField
        }
        
        if isJong {
            
            let decomposedHangul = decomposeHangul(hangul: releaseTextField.last! , lastState: .jong).filter{$0 != " "}
            let newBuffer: CombineBuffer = [decomposedHangul[0], decomposedHangul[1], ""]
            let newKeyboardData = combineHangul(buffer: newBuffer, lastState: .jung)
            isJong = false
            
            releaseTextField[releaseTextField.count - 1] = newKeyboardData.hangul
            
        } else if isDoubleJong {
            
            let decomposedHangul = decomposeHangul(hangul: releaseTextField.last!, lastState: .doubleJong)
            let newBuffer: CombineBuffer = decomposedHangul
            let newKeyboardData = combineHangul(buffer: newBuffer, lastState: .jong)
            isDoubleJong = false
            
            releaseTextField[releaseTextField.count - 1] = newKeyboardData.hangul
        }
        
        if processingBuffer.isCompleted {
            
            let combinedHagul = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
            
            releaseTextField.append(combinedHagul.hangul)
            processingBuffer.isCompleted = false
            
            return releaseTextField
        }
        
        if releaseTextField.count <= 1 {
            
            let newHangul = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
            
            if releaseTextField.isEmpty {
                
                releaseTextField.append(newHangul.hangul)
                
            } else {
                
                if processingBuffer.alphaRepository.count == 1 {
                    
                    releaseTextField.append(newHangul.hangul)
                    
                    return releaseTextField
                }
                
                releaseTextField[0] = newHangul.hangul
            }
            
        } else if releaseTextField.count > 1 {
            
            if releaseTextField.last == " " {
                
                let combinedHagul = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
                releaseTextField.append(combinedHagul.hangul)
                processingBuffer.isCompleted = false
                
                return releaseTextField
                
            } else if processingBuffer.alphaRepository.count == 1 {
                
                let combinedHagul = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
                releaseTextField.append(combinedHagul.hangul)
                processingBuffer.isCompleted = false
                
                return releaseTextField
            }
            
            releaseTextField[releaseTextField.count - 1] = combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState).hangul
        }
        
        return releaseTextField
    }
    
    // MARK: - combineHangul
    
    
    func combineHangul(buffer: CombineBuffer, lastState: HangulKeyboardData.HangulState) -> HangulKeyboardData { // 글자 조합해서 방
        if lastState == .cho && buffer[1] == "" && buffer[2] == "" {
            return HangulKeyboardData(char: buffer[0], state: lastState)
        } else if lastState == .doubleCho && buffer[1] == "" && buffer[2] == "" {
            return HangulKeyboardData(char: buffer[0], state: lastState)
        } else if (lastState == .jung || lastState == .doubleJung) && buffer[0] == "" && buffer[2] == "" {
            return HangulKeyboardData(char: buffer[1], state: lastState)
        }
        
        guard buffer[0] != "" && buffer[1] != "" else {
            return HangulKeyboardData(char: "", state: lastState)
        }
        
        //TODO: - 한글set에 해당 unicode가 없을경우 예외처리 해야함
        let cho = HangulSet.chos.firstIndex(of: buffer[0]) ?? 0
        let jung = HangulSet.jungs.firstIndex(of: buffer[1]) ?? 0
        if buffer.count < 3 {
            let uni2Str = hangulConverter.convertUni2Str(uni: 44032 + cho * 28 * 21 + 28 * jung + 0)
            let uni =  44032 + cho * 28 * 21 + 28 * jung + 0
            let hangul = HangulKeyboardData(char: uni2Str, uni: uni, lastState: lastState)
            
            return hangul
        }
        let jong = HangulSet.jongs.firstIndex(of: buffer[2]) ?? 0
        
        let uni2Str = hangulConverter.convertUni2Str(uni: 44032 + cho * 28 * 21 + 28 * jung + jong)
        let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
        let hangul = HangulKeyboardData(char: uni2Str, uni: uni, lastState: lastState)
        
        return hangul
    }
    
    func combineHangulForDelete(buffer: [String], lastState: HangulKeyboardData.HangulState) -> HangulKeyboardData { // 글자 조합해서 방
        if buffer.count == 1 {
            return HangulKeyboardData(char: buffer[0], state: .cho)
            
        } else if buffer.count == 2 {
            
            let cho = HangulSet.chos.firstIndex(of: buffer[0]) ?? 0
            let jung = HangulSet.jungs.firstIndex(of: buffer[1]) ?? 0
            
            let uni2Str = hangulConverter.convertUni2Str(uni: 44032 + cho * 28 * 21 + 28 * jung + 0)
            let uni =  44032 + cho * 28 * 21 + 28 * jung + 0
            let hangul = HangulKeyboardData(char: uni2Str, uni: uni, lastState: lastState)
            
            return hangul
            
        } else {
            
            let cho = HangulSet.chos.firstIndex(of: buffer[0]) ?? 0
            let jung = HangulSet.jungs.firstIndex(of: buffer[1]) ?? 0
            let jong = HangulSet.jongs.firstIndex(of: buffer[2]) ?? 0
            
            let uni2Str = hangulConverter.convertUni2Str(uni: 44032 + cho * 28 * 21 + 28 * jung + jong)
            let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
            let hangul = HangulKeyboardData(char: uni2Str, uni: uni, lastState: lastState)
            
            return hangul
        }
    }
    
    func decomposeHangul(hangul: String, lastState: HangulKeyboardData.HangulState) -> [String] {
        
        let hangulUnicode = hangulConverter.convertStr2Unicode(char: hangul)
        
        let choIndex = (hangulUnicode - 0xAC00) / 588
        
        guard choIndex >= 0 && choIndex < HangulSet.chos.count else {
            if HangulSet.doubleChos.contains(hangul) && lastState == .cho {
                let singleUni = hangulConverter.convertStr2Unicode(char: hangul) - 1
                return [hangulConverter.convertUni2Str(uni: singleUni)]
            }
            return [hangul]
        }
        
        let removeCho = (hangulUnicode - 0xAC00) % 588
        let jungIndex = removeCho / 28
        let jongIndex = (hangulUnicode - 0xAC00) % 28
        
        let cho = HangulSet.chos[choIndex]
        let jung = HangulSet.jungs[jungIndex]
        let jong = decomposeJongs(str: HangulSet.jongs[jongIndex])
        
        return [cho, jung] + jong
    }
    
    func decomposeJongs(str: String) -> [String] {
        guard let idx = HangulSet.doubleJongs.firstIndex(of: str) else {
            return [str]
        }
        return [HangulSet.checkingJongs[idx].0, HangulSet.checkingJongs[idx].1]
    }
    
    
    
    
    
    
    // MARK: - stage
    
    func emptyStage(status: Status, input: HangulKeyboardData) -> Status {
        
        combineBuffer = ["","",""]
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .empty
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(input.hangul) { // 초성
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) { // 쌍자음
                
                combineBuffer[0] = currentKeyboardData.hangul
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = false
                
                return currentStatus
            }
            
            combineBuffer[0] = currentKeyboardData.hangul
            currentStatus.currentState = .cho
            currentStatus.isCompleted = false
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) { // 이중 모음
                
                combineBuffer[1] = currentKeyboardData.hangul
                currentStatus.isCompleted = true
                currentStatus.currentState = .doubleJung
                
                return currentStatus
            }
            
            combineBuffer[1] = currentKeyboardData.hangul
            currentStatus.isCompleted = true
            currentStatus.currentState = .jung
            
            return currentStatus
            
        } else if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            
            if currentStatus.alphaRepository.count == 0 {
                currentStatus.isCompleted = false
                currentStatus.currentState = .empty
                isdeleting = false
                return currentStatus
            } else {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                combineBuffer = ["", "", ""]
                
                return currentStatus
            }
        }
        
        return currentStatus
    }
    
    //MARK: - 초성 1 스테이지
    func singleChoStage(status: Status, input: HangulKeyboardData) -> Status { // 초성 자음 하나가 들어온 상태
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .cho
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(currentKeyboardData.hangul) { // 초성
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) { // 쌍자음 ex) ㄱㄲ
                
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            // 초성 조합
            // 자음이 하나 있는 상태에서 자음이 하나 더 들어오면 쌍자음을 만들수 있는지 확인 후 있으면 만들어 combineBuffer에 넣어 내보낼 준비 ex) ㄲ
            
            if combineValidator.canMakeDoubleCho(onProcessing: status.alphaRepository.last!.hangul, input: currentKeyboardData.hangul) {
                let combinedChar = combineValidator.combineSingleToDouble(input: hangulConverter.convertStr2Unicode(char: currentKeyboardData.hangul))
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = false
                combineBuffer[0] = hangulConverter.convertUni2Str(uni: combinedChar)
                
                return currentStatus
                
            } else { // 아닐경우 combineBuffer를 비우고 초성 상태로 돌린다. ex) ㄱㅂ
                
                currentStatus.currentState = .cho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) { // 이중 모음
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer[1] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = false
            
            combineBuffer[1] = currentKeyboardData.hangul
            
            return currentStatus
            
        } else if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()// repo에 들어온 delete 값을 지워 줌
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            combineBuffer = ["","",""]
            return currentStatus
        }
        
        return currentStatus
    }
    
    //MARK: - 초성 2 스테이지
    func doubleChoStage(status: Status, input: HangulKeyboardData) -> Status { // 초성 쌍자음이 들어온 상태
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleCho
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(currentKeyboardData.hangul) { // 인풋이 초성
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) { // 쌍자음 ex) ㄲㄲ
                
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData.hangul
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) { // 이중 모음
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer[1] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = false
            combineBuffer[1] = currentKeyboardData.hangul
            
            return currentStatus
            
        } else if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    //MARK: - 중성 1 스테이지
    func singleJungStage(status: Status, input: HangulKeyboardData) -> Status { // 중성인데 input이 들어오는 경우
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .jung
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성이 들어오는 경우 조합이 되는지 확인 후 되면 조합 후 조합중성 stage로 넘기고 아니라면 글자 완성.
            if combineValidator.canMakeDoubleJung(onProcessing: combineBuffer[1], input: currentKeyboardData.hangul) {
                
                let combinedStr = combineValidator.combineSingleJungToDouble(onProcessing: combineBuffer[1], input: currentKeyboardData.hangul)
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer[1] = combinedStr
                
                return currentStatus
            }
            
            combineBuffer = ["","",""]
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer[1] = currentKeyboardData.hangul
            
            return currentStatus
            
        } else if combineBuffer[0] != "" { // 초성이 이미 있다면 초중 완성. 즉, 종성을 받아 조합 되는지 여부 확인
            
            // TODO: - 단일 종성배열로 리팩토링때 다시 한번 분기 가능함.
            if HangulSet.jongs.contains(currentKeyboardData.hangul) { // 종성이 쌍자음일 경우와 아닐 경우의 넘기는 stage 차이 분기
                
                currentStatus.isCompleted = false // MARK: - 이 부분에서 true를 넘길경우 중복으로 쓰여진다.
                combineBuffer[2] = currentKeyboardData.hangul
                
                if HangulSet.doubleJongs.contains(currentKeyboardData.hangul) {
                    
                    currentStatus.currentState = .doubleJong
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .jong
                
                return currentStatus
            }
            
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) { //버퍼에 초성이 없으므로 초성인 경우 -> 이 시점에서 글자를 완성 시키고 combineBuffer를 비워야 함.
            
            combineBuffer = ["","",""]
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData.hangul
            
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                currentStatus.currentState = .doubleCho
                
                return currentStatus
            }
            
            currentStatus.currentState = .cho
            
            return currentStatus
            
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func doubleJungStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleJung
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성이 들어오는 경우 조합이 되는지 확인 후 되면 조합 후 조합중성 stage로 넘기고 아니라면 글자 완성.
            
            if combineValidator.canMakeTripleJung(onProcessing: combineBuffer[1], input: currentKeyboardData.hangul) {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = .doubleJong
                let newJung = combineValidator.combineTripleJungToDouble(onProcessing: combineBuffer[1], input: currentKeyboardData.hangul)
                combineBuffer[1] = newJung
                
                return currentStatus
                
            } else if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                
                combineBuffer = ["","",""]
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = true
                combineBuffer[1] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            combineBuffer = ["","",""]
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer[1] = currentKeyboardData.hangul
            
            return currentStatus
            
        } else if combineBuffer[0] != "" {
            // TODO: - 단일 종성배열로 리팩토링때 다시 한번 분기 가능함.
            if HangulSet.jongs.contains(currentKeyboardData.hangul) { // 종성이 쌍자음일 경우와 아닐 경우의 넘기는 stage 차이 분기
                if HangulSet.doubleJongs.contains(currentKeyboardData.hangul) {
                    
                    currentStatus.currentState = .doubleJong
                    // MARK: - 이 부분에서 true를 넘길경우 중복으로 쓰여진다.
                    currentStatus.isCompleted = false
                    combineBuffer[2] = currentKeyboardData.hangul
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .jong
                currentStatus.isCompleted = false
                combineBuffer[2] = currentKeyboardData.hangul
                
                return currentStatus
            }
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) { //버퍼에 초성이 없으므로 초성인 경우 -> 이 시점에서 글자를 완성 시키고 combineBuffer를 비워야 함.
            // 인풋이 초성
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                combineBuffer = ["","",""]
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData.hangul
                
                return currentStatus
            }
            
            combineBuffer = ["","",""]
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData.hangul
            
            return currentStatus
        } else if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func singleJongStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .jong
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성이 들어오는 경우 조합
            
            currentStatus.isCompleted = true
            isJong = true
            combineBuffer[0] = combineBuffer[2]
            combineBuffer[1] = currentKeyboardData.hangul
            combineBuffer[2] = ""
            currentStatus.currentState = .jung
            
            // repo의 배열 마지막을 분해해서 그 분해한 마지막 배열을 가져온 다음 분해한 것의 세번째 까지만 repo의 마지막에서 두번째 배열에 넣고 분해한것의 마지막 것은 지금 들어온 str과 합쳐서 마지막 배열에 붙혀줌
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                //중성이 들어오는 경우 초성을 새로 들어온 종성으로 바꾸고 종성을 비운뒤 방출한다.
                isDoubleJong = true
                currentStatus.currentState = .doubleJung
                
                return currentStatus
            }
            
            return currentStatus
            
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) { // 종성이 있는데 자음이 들어올 때
            // 우선 들어온 자음과 기존 자음이 조합 되는지 확인
            if combineValidator.canMakeDoubleJong(onProcessing: combineBuffer[2], input: currentKeyboardData.hangul) { // 종성 조합 가능
                
                currentStatus.currentState = .doubleJong
                currentStatus.isCompleted = false
                let combinedDoubleJong = combineValidator.combineSingleJongToDouble(onProcessing: combineBuffer[2], input: currentKeyboardData.hangul)
                combineBuffer[2] = combinedDoubleJong
                
                return currentStatus
            }
            
            // 조합이 안된다면 초성으로 넘긴다.
            combineBuffer = ["","",""]
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData.hangul
            
            return currentStatus
            
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func doubleJongStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleJong
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(input.hangul) { // 초성
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) { // 쌍자음
                
                combineBuffer = ["","",""]
                combineBuffer[0] = currentKeyboardData.hangul
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                
                return currentStatus
            }
            
            combineBuffer = ["","",""]
            combineBuffer[0] = currentKeyboardData.hangul
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) { // 중성
            
            currentStatus.isCompleted = true
            isDoubleJong = true
            combineBuffer[0] = currentStatus.alphaRepository[currentStatus.alphaRepository.count - 2].hangul
            combineBuffer[1] = currentKeyboardData.hangul
            combineBuffer[2] = ""
            
            currentStatus.currentState = .jung
            
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) { // 이중 모음
                currentStatus.currentState = .doubleJung
                return currentStatus
            }
            
            return currentStatus
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            isdeleting = true
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
}
