//
//  space_input_Tests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/17.
//

import XCTest
@testable import CustomKeyboard

class space_input_Tests: XCTestCase {

    var ioManager = HangeulIOManger()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }


    func testExample1() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㄴ", "Back", "Back", "Back", "Back", "Back", "ㄴ", "ㅕ", "ㅇ", "Back", "Space", "Space"]
        let expectation = "녀  "
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample2() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅗ.rawValue) + c.toString(from: HangeulDictionary.fixed.top.ㄴ.rawValue) + "계자  욉금지"
        //  "ㅗㄴ계자  욉금지"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

    func testExample3() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "Space", "Space", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅗ.rawValue) + c.toString(from: HangeulDictionary.fixed.top.ㄴ.rawValue) + "계자  외  " + c.toString(from: HangeulDictionary.fixed.top.ㅂ.rawValue) + "금지" // "ㅗㄴ계자  외  ㅂ금지"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample4() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㄱ", "Back", "ㅗ", "ㅏ", "Back", "ㄴ", "ㄱ", "ㅖ", "ㅈ", "ㅏ", "Space", "Space", "ㅇ", "ㅗ", "ㅣ", "ㅊ", "ㅜ", "Back", "ㄹ", "ㅇ", "Back", "Back", "Back", "Back", "ㅣ", "Space", "Space", "ㅂ", "ㄱ", "ㅡ", "ㅁ", "ㅈ", "ㅣ", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅗ.rawValue) + c.toString(from: HangeulDictionary.fixed.top.ㄴ.rawValue) + "계자  오" // "ㅗㄴ계자  오"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample5() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㅓ", "ㅣ", "ㅓ", "ㅣ", "Back", "ㅏ", "ㅣ", "ㅏ", "ㅣ", "Back", "ㅑ", "ㅣ", "ㅑ", "ㅣ", "Back", "ㅕ", "ㅣ", "ㅕ", "ㅣ", "Back"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅔ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅓ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅐ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅏ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅒ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅑ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅖ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅕ.rawValue)
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
}
