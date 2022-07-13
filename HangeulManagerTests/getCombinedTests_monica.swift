//
//  getCombinedTests_monica.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/13.
//

import XCTest
@testable import CustomKeyboard

class getCombinedTests_monica: XCTestCase {

    var hangeulManager: HangeulManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        hangeulManager = HangeulManager.shared
    }

    override func tearDownWithError() throws {
        hangeulManager.reset()
    }

    func testGetCombinedWord1() throws {
        let input = ["ㄲ", "ㅏ", ""]
        let expectation = "까"
        let result = hangeulManager.getCombinedWord(input[0], input[1], input[2])
        
        XCTAssertEqual(result, expectation, "초성 + 중성 에러")
    }
    
    func testGetCombinedWord2() throws {
        let input = ["ㄸ", "ㅚ", ""]
        let expectation = "뙤"
        let result = hangeulManager.getCombinedWord(input[0], input[1], input[2])
        
        XCTAssertEqual(result, expectation, "초성 + 겹모음 에러")
    }
    
    func testGetCombinedWord3() throws {
        let input = ["ㅎ", "ㅠ", "ㅇ"]
        let expectation = "흉"
        let result = hangeulManager.getCombinedWord(input[0], input[1], input[2])
        
        XCTAssertEqual(result, expectation, "초성 + 중성 + 종성 에러")
    }
    
    func testGetCombinedWord4() throws {
        let input = ["ㅎ", "ㅟ", "ㅇ"]
        let expectation = "휭"
        let result = hangeulManager.getCombinedWord(input[0], input[1], input[2])
        
        XCTAssertEqual(result, expectation, "초성 + 겹모음 + 종성 에러")
    }
    
    func testGetCombinedWord5() throws {
        let input = ["ㅁ", "ㅜ", "ㄻ"]
        let expectation = "묾"
        let result = hangeulManager.getCombinedWord(input[0], input[1], input[2])
        
        XCTAssertEqual(result, expectation, "초성 + 중성 + 겹받침 에러")
    }
    
    func testGetCombinedWord6() throws {
        let input = ["ㅎ", "ㅟ", "ㄻ"]
        let expectation = "휢"
        let result = hangeulManager.getCombinedWord(input[0], input[1], input[2])
        
        XCTAssertEqual(result, expectation, "초성 + 겹모음 + 겹받침 에러")
    }

}
