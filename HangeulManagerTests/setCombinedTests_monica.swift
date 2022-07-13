//
//  setCombinedTests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/13.
//

import XCTest
@testable import CustomKeyboard

class setCombinedTests: XCTestCase {

    var hangeulManager: HangeulManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        hangeulManager = HangeulManager.shared
    }

    override func tearDownWithError() throws {
        hangeulManager.reset()
    }

    func testSetCombinedBuffer1() throws {
        hangeulManager.reset()
        let input = ["ㅂ", "ㅓ", "ㅁ", "ㅈ", "ㅗ", "ㅣ", "ㄷ", "ㅗ", "ㅅ", "ㅣ", "ㅉ", "ㅏ", "ㅇ", "ㅈ", "ㅐ", "ㅁ", "ㅣ", "ㅆ", "ㄷ", "ㅏ"]
        let expectation = "범죄도시짱재밌다"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testSetCombinedBuffer2() throws {
        hangeulManager.reset()
        let input = ["ㄷ", "ㅏ", "ㄹ", "ㄱ", "ㅑ", "ㄹ"]
        let expectation = "달걀"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }

    func testSetCombinedBuffer3() throws {
        hangeulManager.reset()
        let input = ["ㅅ", "ㅏ", "ㄹ", "ㅋ", "ㅗ", "ㅐ", "ㅇ", "ㅇ", "ㅣ", "ㄱ", "ㅏ", "ㅇ", "ㅜ", "ㄴ", "ㅡ", "ㄴ", "ㅅ", "ㅗ", "ㄹ", "ㅣ"]
        let expectation = "살쾡이가우는소리"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testSetCombinedBuffer4() throws {
        hangeulManager.reset()
        let input = ["ㄲ", "ㄱ", "ㅜ", "ㅓ", "ㅗ", "ㅐ", "ㅇ", "ㅅ"]
        let expectation = String(UnicodeScalar(HG.fixed.top.sssangKiyeok)!) + "궈" + String(UnicodeScalar(HG.fixed.mid.wae)!) +  String(UnicodeScalar(HG.fixed.top.ieung)!) + String(UnicodeScalar(HG.fixed.top.sios)!) // "ㄲ궈ㅙㅇㅅ"
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }
    
    func testSetCombinedBuffer5() throws {
        hangeulManager.reset()
        let input = ["ㅠ", "ㅠ", "ㅠ", "ㅠ", "ㅠ"]
        let expectation = String(UnicodeScalar(HG.fixed.mid.yu)!) + String(UnicodeScalar(HG.fixed.mid.yu)!) + String(UnicodeScalar(HG.fixed.mid.yu)!) + String(UnicodeScalar(HG.fixed.mid.yu)!) + String(UnicodeScalar(HG.fixed.mid.yu)!)
        for char in input {
            hangeulManager.update(char)
        }
        let result = hangeulManager.getOutputString()
        
        XCTAssertEqual(result, expectation)
    }

}
