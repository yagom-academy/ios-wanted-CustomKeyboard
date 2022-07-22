//
//  double_input_Tests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/20.
//

import XCTest
@testable import CustomKeyboard

class double_input_Tests: XCTestCase {

    var ioManager = HangeulIOManger()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }

    func testExample1() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅗ", "ㅐ", "ㄴ"]
        let expectation = "괜"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

}
