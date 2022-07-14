//
//  backCaseRefactoringTests_monica.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/14.
//

import XCTest
@testable import CustomKeyboard

class backCaseRefactoringTests_monica: XCTestCase {

    var ioManager : IOManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        ioManager = IOManager.shared
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }

    func testBackCase1() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back"]
        let expectation = "범조"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase2() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "Back", "ㅈ"]
        let expectation = "범조도시짲"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase3() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "Back", "ㅈ", "ㅐ", "ㅁ", "ㅣ", "Back", "ㅆ", "ㄷ", "ㅏ"]
        let expectation = "범조도시짜재" + String(UnicodeScalar(HG.fixed.top.mieum)!) + String(UnicodeScalar(HG.fixed.top.ssangSios)!) + "다" // "범조도시짜재ㅁㅆ다
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase4() throws {
        ioManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) // "ㅗㄴ"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }

    func testBackCase5() throws {
        ioManager.reset()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.o)!) + String(UnicodeScalar(HG.fixed.top.nieun)!) + "계자욉금지" // "ㅗㄴ계자욉금지"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase6() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "ㄴ", "ㅕ", "ㅇ", "Back"]
        let expectation = "아녀"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase7() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "Back", "Back", "Back", "Back", "ㄴ", "ㅕ", "ㅇ", "Back"]
        let expectation = "녀"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase8() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㅏ", "ㅏ", "Back", "Back"]
        let expectation = "아"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testBackCase9() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅏ", "ㄹ", "ㄱ", "ㅇ", "ㅏ", "Back", "Back", "Back"]
        let expectation = "갈"
        for char in input {
            ioManager.process(input: char)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(result, expectation)
    }
}
