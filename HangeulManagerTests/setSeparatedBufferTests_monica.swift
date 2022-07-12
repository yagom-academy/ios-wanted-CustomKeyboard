//
//  CustomKeyboardTests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/13.
//

import XCTest
@testable import CustomKeyboard

class setSeparatedBufferTests: XCTestCase {

    var hangeulManager: HangeulManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        hangeulManager = HangeulManager.shared
    }

    override func tearDownWithError() throws {
        hangeulManager.reset()
    }

    func testSetSeparatedBuffer1() throws {
        hangeulManager.reset()
        let input = HangeulCharacter.choseong.randomElement()!
        let expectation = 1
        hangeulManager.update(input)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 입력시 에러")
    }

    func testSetSeparatedBuffer2() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let expectation = 2
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer3() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅗ"
        let input3 = "ㅏ"
        let expectation = 2
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 입력시 에러")
    }
    
    func testSetSeparatedBuffer4() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.choseong.randomElement()!
        let expectation = 1
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 초성 입력시 에러")
    }
    
    func testSetSeparatedBuffer5() throws {
        hangeulManager.reset()
        let input = HangeulCharacter.jungseong.randomElement()!
        let expectation = 0
        hangeulManager.update(input)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer6() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let input3 = HangeulCharacter.jongseong.randomElement()!
        let expectation = 3
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 종성 입력시 에러")
    }
    
    func testSetSeparatedBuffer7() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅡ"
        let input3 = "ㅣ"
        let input4 = HangeulCharacter.jongseong.randomElement()!
        let expectation = 3
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 -> 종성 입력시 에러")
    }
    
    func testSetSeparatedBuffer8() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let input3 = "ㄹ"
        let input4 = "ㅁ"
        let expectation = 3
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 겹받침 입력시 에러")
    }
    
    func testSetSeparatedBuffer9() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅏ"
        let input3 = "ㅗ"
        let expectation = 0
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer10() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅡ"
        let input3 = "ㅣ"
        let input4 = "ㄹ"
        let input5 = "ㅁ"
        let expectation = 3
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 -> 겹받침 입력시 에러")
    }
    
    func testSetSeparatedBuffer11() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let input3 = "ㄹ"
        let input4 = "ㅁ"
        let input5 = HangeulCharacter.jungseong.randomElement()!
        let expectation = 2
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 겹받침 -> 중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer12() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅡ"
        let input3 = "ㅣ"
        let input4 = "ㄹ"
        let input5 = "ㅁ"
        let input6 = HangeulCharacter.jungseong.randomElement()!
        let expectation = 2
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        hangeulManager.update(input6)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 -> 겹받침 -> 중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer13() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let input3 = "ㄹ"
        let input4 = HangeulCharacter.jungseong.randomElement()!
        let expectation = 2
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 종성 -> 중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer14() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅗ"
        let input3 = "ㅏ"
        let input4 = HangeulCharacter.jongseong.randomElement()!
        let input5 = HangeulCharacter.jungseong.randomElement()!
        let expectation = 2
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 -> 종성 -> 중성 입력시 에러")
    }
    
    func testSetSeparatedBuffer15() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let input3 = HangeulCharacter.jongseong.randomElement()!
        let input4 = "ㅍ"
        let expectation = 1
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 종성 -> 초성 입력시 에러")
    }
    
    func testSetSeparatedBuffer16() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = HangeulCharacter.jungseong.randomElement()!
        let input3 = "ㄹ"
        let input4 = "ㅁ"
        let input5 = "ㅅ"
        let expectation = 1
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 중성 -> 겹받침 -> 초성 입력시 에러")
    }
    
    func testSetSeparatedBuffer17() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅗ"
        let input3 = "ㅏ"
        let input4 = HangeulCharacter.jungseong.randomElement()!
        let input5 = "ㅅ"
        let expectation = 1
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 -> 중성 -> 초성 입력시 에러")
    }
    
    func testSetSeparatedBuffer18() throws {
        hangeulManager.reset()
        let input1 = HangeulCharacter.choseong.randomElement()!
        let input2 = "ㅗ"
        let input3 = "ㅏ"
        let input4 = "ㄹ"
        let input5 = "ㅁ"
        let input6 = "ㄱ"
        let expectation = 1
        hangeulManager.update(input1)
        hangeulManager.update(input2)
        hangeulManager.update(input3)
        hangeulManager.update(input4)
        hangeulManager.update(input5)
        hangeulManager.update(input6)
        let result = hangeulManager.getSeparatedBufferCount()
        
        XCTAssertEqual(result, expectation, "초성 -> 겹모음 -> 겹받침 -> 초성 입력시 에러")
    }
}
