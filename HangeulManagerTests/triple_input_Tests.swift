//
//  triple_input_Tests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/19.
//

import XCTest
@testable import CustomKeyboard

class triple_input_Tests: XCTestCase {

    var ioManager = HangeulIOManger()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }
    
    func testExample1() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅗ", "ㅏ", "ㅣ"]
        let expectation = "괘"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample2() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅜ", "ㅓ", "ㅣ"]
        let expectation = "궤"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample3() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅗ", "ㅏ", "ㅣ", "Space", "Back", "ㄴ"]
        let expectation = "괜"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample4() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅜ", "ㅓ", "ㅣ", "Space", "Back", "Back"]
        let expectation = "궈"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

}
