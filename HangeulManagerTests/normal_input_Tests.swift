//
//  normal_input_Tests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/17.
//

import XCTest
@testable import CustomKeyboard

final class normal_input_Tests: XCTestCase {

    var ioManager = HangeulIOManger()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }

    func testExample1() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅏ", "ㄴ", "ㅏ"]
        let expectation = "가나"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)   
    }
    
    func testExample2() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㅏ", "ㅏ", "ㄴ", "ㅏ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅏ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅏ.rawValue) + "나"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

    func testExample3() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㅏ", "ㅣ", "ㄴ", "ㅏ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅐ.rawValue) + "나"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample4() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "ㄷ", "ㅗ", "ㅅ", "ㅣ"]
        let expectation = "범죄도시"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample5() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㄱ", "ㅏ", "ㄱ", "ㅅ", "ㅓ"]
        let expectation = "범죄도시각서"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample6() throws {
        ioManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㄱ", "ㅏ", "ㄱ", "ㅅ"]
        let expectation = "범죄도시갃"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample7() throws {
        ioManager.reset()
        let c = HangeulConverter()
        let input = ["ㅓ", "ㅏ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㄱ", "ㅏ", "ㄱ", "ㅅ"]
        let expectation = c.toString(from: HangeulDictionary.fixed.mid.ㅓ.rawValue) + c.toString(from: HangeulDictionary.fixed.mid.ㅏ.rawValue) + c.toString(from: HangeulDictionary.fixed.top.ㅁ.rawValue) + "죄도시갃"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

}
