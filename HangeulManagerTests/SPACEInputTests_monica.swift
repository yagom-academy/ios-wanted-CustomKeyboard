//
//  SPACEInputTests_monica.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/14.
//

import XCTest
@testable import CustomKeyboard

class SPACEInputTests_monica: XCTestCase {

    var hangeulManager: HangeulManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        hangeulManager = HangeulManager.shared
    }

    override func tearDownWithError() throws {
        hangeulManager.reset()
    }
    
    func testSpaceInput1() throws {
        hangeulManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "Back", "Back", "Back", "Back", "ㄴ", "ㅕ", "ㅇ", "Back", "Space", "Space"]
        let expectation = "녀  "
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation, "글자 다 쓴 뒤에 스페이스 추가")
    }
    
    func testSpaceInput2() throws {
        hangeulManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자  욉금지" // "ㅗㄴ계자  욉금지"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation, "글자 중간에 스페이스 추가")
    }
    
    func testSpaceInput3() throws {
        hangeulManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "Space", "Space", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자  외  " + String(UnicodeScalar(HG.fixed.top.bieub)!) + "금지" // "ㅗㄴ계자  외  ㅂ금지"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation, "글자 중간에 백스페이스 + 스페이스 추가")
    }
    
    func testSpaceInput4() throws {
        hangeulManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "Space", "Space", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자  오" // "ㅗㄴ계자  오"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation, "글자 끝에 백스페이스 믾이 추가해서 스페이스쳤던 것까지 지우는 경우")
    }

}
