//
//  back_input_Tests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/17.
//

import XCTest
@testable import CustomKeyboard

final class back_input_Tests: XCTestCase {

    var ioManager = HangeulIOManger()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }

    func testExample1() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅏ", "ㄴ", "Back"]
        let expectation = "가"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample2() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅏ", "ㄴ", "ㅏ", "Back"]
        let expectation = "간"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample3() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㅓ", "ㅏ", "ㅓ", "ㅏ", "Back", "Back", "Back"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅓ.rawValue)
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample4() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back"]
        let expectation = "범조"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample5() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "Back", "ㅈ"]
        let expectation = "범조도시짲"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample6() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "Back", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "Back", "ㅈ", "ㅐ", "ㅁ", "Back", "ㅆ", "ㄷ", "ㅏ"]
        let expectation = "범조도시짜쟀다" // "범조도시짜쟀다"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample7() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅗ.rawValue) + c.toString(from: HangeulDictionary.fixed.top.ㄴ.rawValue) // "ㅗㄴ"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample8() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅗ.rawValue) + c.toString(from: HangeulDictionary.fixed.top.ㄴ.rawValue) + "계자욉금지" // "ㅗㄴ계자욉금지"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample9() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "ㄴ", "ㅕ", "ㅇ", "Back"]
        let expectation = "아녀"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample10() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㅏ", "ㅏ", "Back", "Back"]
        let expectation = "아"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample11() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅏ", "ㄹ", "ㄱ", "ㅇ", "ㅏ", "Back", "Back", "Back"]
        let expectation = "갈"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

}
