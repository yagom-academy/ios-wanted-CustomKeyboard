//
//  spaceCaseRefactoringTests_monica.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/14.
//

import XCTest
@testable import CustomKeyboard

class spaceCaseRefactoringTests_monica: XCTestCase {

    var ioManager : IOManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        ioManager = IOManager.shared
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }

    func testSpaceCase1() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "Back", "Back", "Back", "Back", "ㄴ", "ㅕ", "ㅇ", "Back", "Space", "Space"]
        let expectation = "녀  "
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation, "글자 다 쓴 뒤에 스페이스 추가")
    }

    func testSpaceCase2() throws {
        ioManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자  욉금지" // "ㅗㄴ계자  욉금지"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation, "글자 중간에 스페이스 추가")
    }
    
    func testSpaceCase3() throws {
        ioManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "Space", "Space", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자  외  " + String(UnicodeScalar(HG.fixed.top.bieub)!) + "금지" // "ㅗㄴ계자  외  ㅂ금지"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation, "글자 중간에 백스페이스 + 스페이스 추가")
    }
    
    func testSpaceCase4() throws {
        ioManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "Space", "Space", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자  오" // "ㅗㄴ계자  오"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation, "글자 끝에 백스페이스 믾이 추가해서 스페이스쳤던 것까지 지우는 경우")
    }

}
