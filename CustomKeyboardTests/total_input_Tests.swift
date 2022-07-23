//
//  total_input_Tests.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/22.
//

import XCTest
@testable import CustomKeyboard

class total_input_Tests: XCTestCase {

    var ioManager = HangeulIOManger()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        ioManager.reset()
    }

    func testExample1() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅡ", "ㄷ", "ㅐ", "Space", "ㅇ", "ㅓ", "ㅂ", "ㅅ", "ㅇ", "ㅣ", "Space", "ㄴ", "ㅏ", "ㄴ", "Space", "ㅎ", "ㅏ", "ㄴ", "Space", "ㅉ", "ㅗ", "ㄱ", "Space", "ㄷ", "ㅏ", "ㄹ", "ㅣ", "ㄱ", "ㅏ", "Space", "ㅉ", "ㅏ", "ㄹ", "ㅂ", "ㅇ", "ㅡ", "ㄴ", "Space", "ㅇ", "ㅡ", "ㅣ", "ㅈ", "ㅏ", "Back", "Back", "Back", "ㅈ", "ㅏ"]
        let expectation = "그대 없이 난 한 쪽 다리가 짧은 으자"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample2() throws {
        ioManager.reset()
        let input = ["ㅇ", "ㅏ", "ㅁ", "ㅎ", "ㅗ", "ㄴ", "ㅡ", "ㄴ", "Space", "ㅇ", "Back", "Back", "Back", "ㄴ", "Space", "ㅇ", "ㅕ", "ㄹ", "ㄹ", "ㅕ", "ㄹ", "ㅏ", "Space", "ㅊ", "ㅏ", "ㅁ", "ㄲ", "ㅏ", "ㅣ", "Back", "ㅣ"]
        let expectation = "암호는 열려라 참깨"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample3() throws {
        ioManager.reset()
        let input = ["ㄱ", "ㅜ", "ㅓ", "ㄹ", "ㄱ", "ㅅ", "ㅓ", "Space", "Space", "Back", "Back", "ㅂ", "ㅅ", "ㅆ", "ㅏ", "ㄹ", "ㅎ", "ㄲ", "ㅜ", "ㅓ", "ㅣ", "ㄴ", "ㅎ", "Back", "Back", "Back", "Back", "ㅔ", "ㄴ", "ㅎ"]
        let expectation = "궑섮쌇꿶"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

    func testExample4() throws {
        ioManager.reset()
        let c = HangeulConverter()
        
        let input = ["ㄱ", "ㅜ", "ㅓ", "ㄹ", "Space", "ㄱ", "Back", "ㄱ", "ㅅ", "ㅓ", "Space", "Space", "Back", "Back", "ㅂ", "ㅅ", "ㅆ", "ㅏ", "ㄹ", "ㅎ", "ㄲ", "ㅜ", "ㅓ", "ㅣ", "ㄴ", "ㅎ", "Back", "Back", "Back", "Back", "ㅔ", "ㄴ", "ㅎ", "Space"]
        let expectation = "궐 " + c.toString(from: HangeulUnicodeType.Fixed.choseong.ㄱ.rawValue)! + "섮쌇꿶 "
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample5() throws {
        ioManager.reset()
        let c = HangeulConverter()

        let input = ["ㅎ", "ㅎ", "ㅎ", "ㅎ", "ㅎ", "ㅎ", "ㅎ", "ㅎ", "Space", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "ㅎ", "ㅎ", "ㅎ", "Back"]
        let expectation = c.toString(from: HangeulUnicodeType.Fixed.choseong.ㅎ.rawValue)! + c.toString(from: HangeulUnicodeType.Fixed.choseong.ㅎ.rawValue)!
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample6() throws {
        ioManager.reset()
        let c = HangeulConverter()

        let input = ["ㅠ", "ㅓ", "ㅣ", "ㅜ", "ㅓ", "ㅣ", "ㅗ", "ㅏ", "Space", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "ㅗ", "ㅐ", "ㅠ", "Back"]
        let expectation = c.toString(from: HangeulUnicodeType.Fixed.jungseong.ㅙ.rawValue)!
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample7() throws {
        ioManager.reset()
        
        let input = ["Space", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Space", "Space", "Space", "Space", "Back"]
        let expectation = "   "
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample8() throws {
        ioManager.reset()
        let c = HangeulConverter()

        let input = ["Space", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Space", "Space", "Space", "Space", "Back", "ㄱ", "ㅅ"]
        let expectation = "   " + c.toString(from: HangeulUnicodeType.Fixed.choseong.ㄱ.rawValue)! + c.toString(from: HangeulUnicodeType.Fixed.choseong.ㅅ.rawValue)!
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample9() throws {
        ioManager.reset()
        let c = HangeulConverter()

        let input = ["Space", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Back", "Space", "Space", "Space", "Space", "Back", "ㅜ", "ㅓ"]
        let expectation = "   " + c.toString(from: HangeulUnicodeType.Fixed.jungseong.ㅝ.rawValue)!
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }
    
    func testExample10() throws {
        ioManager.reset()

        let input = ["ㅂ", "ㅕ", "ㄹ", "ㅊ", "ㅓ", "ㄹ", "ㅓ", "ㅁ", "Space", "ㅎ", "ㅗ", "ㅏ", "ㄴ", "ㅎ", "ㅣ", "Space", "ㅂ", "ㅣ", "ㅊ", "ㄴ", "ㅏ", "ㄱ", "ㅣ", "ㅇ", "ㅓ", "ㅣ", "Back", "Back", "ㅔ"]
        let expectation = "별처럼 환히 빛나기에"
        
        for ele in input {
            ioManager.process(input: ele)
        }
        let result = ioManager.getOutput()
        
        XCTAssertEqual(expectation, result)
    }

}
