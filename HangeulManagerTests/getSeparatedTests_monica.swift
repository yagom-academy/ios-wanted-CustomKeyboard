//
//  SeparatedTests_monica.swift
//  CustomKeyboardTests
//
//  Created by hayeon on 2022/07/13.
//

import XCTest
@testable import CustomKeyboard

class getSeparatedTests_monica: XCTestCase {

    var hangeulManager: HangeulManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        hangeulManager = HangeulManager.shared
    }

    override func tearDownWithError() throws {
        hangeulManager.reset()
    }

    func testGetSeparatedCharacters1() throws {
        
        let input = "가"
        let expectation = [String(UnicodeScalar(HangeulCharacter.firstChoseongUnicodeValue)!) ,String(UnicodeScalar(HangeulCharacter.firstJungseongUnicodeValue)!) , String(UnicodeScalar(HangeulCharacter.firstJongseongUnicodeValue)!)]
        let result = hangeulManager.getSeparatedCharacters(from: input)
        
        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 중성 에러")
        }
        
    }
    
    func testGetSeparatedCharacters2() throws {
        let input = "감"
        let expectation = [String(UnicodeScalar(HangeulCharacter.firstChoseongUnicodeValue)!), String(UnicodeScalar(HangeulCharacter.firstJungseongUnicodeValue)!), String(UnicodeScalar(0x11B7)!)]
        let result = hangeulManager.getSeparatedCharacters(from: input)
        
        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 중성 + 종성 에러")
        }
        
    }
    
    func testGetSeparatedCharacters3() throws {
        let input = "굄"
        let expectation = [String(UnicodeScalar(HangeulCharacter.firstChoseongUnicodeValue)!), String(UnicodeScalar(0x116c)!), String(UnicodeScalar(0x11B7)!)]
        let result = hangeulManager.getSeparatedCharacters(from: input)
        
        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 겹모음 + 종성 에러")
        }
        
    }
    
    func testGetSeparatedCharacters4() throws {
        let input = "괾"
        let expectation = [String(UnicodeScalar(HangeulCharacter.firstChoseongUnicodeValue)!), String(UnicodeScalar(0x116c)!), String(UnicodeScalar(0x11B1)!)]
        let result = hangeulManager.getSeparatedCharacters(from: input)
        
        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 겹모음 + 겹받침 에러")
        }
        
    }
    
    func testGetSeparatedCharacters5() throws {
        let input = "갊"
        let expectation = [String(UnicodeScalar(HangeulCharacter.firstChoseongUnicodeValue)!) ,String(UnicodeScalar(HangeulCharacter.firstJungseongUnicodeValue)!) , String(UnicodeScalar(0x11B1)!)]
        let result = hangeulManager.getSeparatedCharacters(from: input)
        
        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 종성 + 겹받침 에러")
        }
        
    }
    
    func testGetSeparatedCharacters6() throws {
        let input = "괴"
        let expectation = [String(UnicodeScalar(HangeulCharacter.firstChoseongUnicodeValue)!), String(UnicodeScalar(0x116c)!), String(UnicodeScalar(HangeulCharacter.firstJongseongUnicodeValue)!)]
        let result = hangeulManager.getSeparatedCharacters(from: input)
        
        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 겹모음 에러")
        }
        
    }

}
