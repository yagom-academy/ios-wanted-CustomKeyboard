//
//  KeyBoardEngine_removeWord_Test_kirkim.swift
//  KeyBoardEngineTest_kirkim
//
//  Created by 김기림 on 2022/07/15.
//

import XCTest
@testable import CustomKeyboard

class KeyBoardEngine_removeWord_Test_kirkim: XCTestCase {
    var sut:KeyBoardEngine?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FirstKeyBoardEngine()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_removeWord호출시_ㄱ_입력시_공백반환되는지() {
        let input = 12593
        let result = ""
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅘ_입력시_ㅗ반환되는지() {
        let input = 12632
        let result = "ㅗ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅙ_입력시_ㅗ반환되는지() {
        let input = 12633
        let result = "ㅗ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅚ_입력시_ㅗ반환되는지() {
        let input = 12634
        let result = "ㅗ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅝ_입력시_ㅜ반환되는지() {
        let input = 12637
        let result = ""
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅞ_입력시_ㅜ반환되는지() {
        let input = 12638
        let result = ""
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅟ_입력시_ㅜ반환되는지() {
        let input = 12639
        let result = ""
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅢ_입력시_ㅡ반환되는지() {
        let input = 12642
        let result = ""
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핛_입력시_학반환되는지() {
        let input = 54619
        let result = "학"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핝_입력시_한반환되는지() {
        let input = 54621
        let result = "한"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핞_입력시_한반환되는지() {
        let input = 54622
        let result = "한"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핡_입력시_할반환되는지() {
        let input = 54625
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핢_입력시_할반환되는지() {
        let input = 54626
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핣_입력시_할반환되는지() {
        let input = 54627
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핤_입력시_할반환되는지() {
        let input = 54628
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핥_입력시_할반환되는지() {
        let input = 54629
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핦_입력시_할반환되는지() {
        let input = 54630
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핧_입력시_할반환되는지() {
        let input = 54631
        let result = "할"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_핪_입력시_합반환되는지() {
        let input = 54634
        let result = "합"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
}
