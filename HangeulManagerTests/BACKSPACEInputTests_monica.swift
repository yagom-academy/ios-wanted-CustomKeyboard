//
//  BACKSPACEInputTests_monica.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/13.
//

import XCTest
@testable import CustomKeyboard

class BACKSPACEInputTests_monica: XCTestCase {

    var hangeulManager: HangeulManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        hangeulManager = HangeulManager.shared
    }

    override func tearDownWithError() throws {
        hangeulManager.reset()
    }

    func testBACKSPACEInput1() throws {
        hangeulManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back"]
        let expectation = "범조"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput2() throws {
        hangeulManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "Back", "ㅈ"]
        let expectation = "범조도시짲"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput3() throws {
        hangeulManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "Back", "ㅈ", "ㅐ", "ㅁ", "ㅣ", "Back", "ㅆ", "ㄷ", "ㅏ"]
        let expectation = "범조도시짜재" + String(UnicodeScalar(HG.fixed.top.mieum)!) + String(UnicodeScalar(HG.fixed.top.ssangSios)!) + "다" // "범조도시짜재ㅁㅆ다
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput4() throws {
        hangeulManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) // "ㅗㄴ"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput5() throws {
        hangeulManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자욉금지" // "ㅗㄴ계자욉금지"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput6() throws {
        hangeulManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "ㄴ", "ㅕ", "ㅇ", "Back"]
        let expectation = "아녀"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput7() throws {
        hangeulManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "Back", "Back", "Back", "Back", "ㄴ", "ㅕ", "ㅇ", "Back"]
        let expectation = "녀"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBACKSPACEInput8() throws {
        hangeulManager.reset()
        let input = ["ㅇ", "ㅏ", "ㅏ", "ㅏ", "Back", "Back"]
        let expectation = "아"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }

    
    

}
