//
//  KeyBoardEngine_removeWord_Test_kirkim.swift
//  KeyBoardEngineTest_kirkim
//
//  Created by 김기림 on 2022/07/15.
//

import XCTest
@testable import CustomKeyboard

class KeyBoardEngine_removeWord__test: XCTestCase {
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
    
    func test_removeWord호출시_ㅣ_입력시_공백반환되는지() {
        let input = 12643
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
        let result = "ㅜ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅞ_입력시_ㅜ반환되는지() {
        let input = 12638
        let result = "ㅜ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅟ_입력시_ㅜ반환되는지() {
        let input = 12639
        let result = "ㅜ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_ㅢ_입력시_ㅡ반환되는지() {
        let input = 12642
        let result = "ㅡ"
        
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
    
    func test_removeWord호출시_합_입력시_하반환되는지() {
        let input = 54633
        let result = "하"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_하_입력시_ㅎ반환되는지() {
        let input = 54616
        let result = "ㅎ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_안_입력시_아반환되는지() {
        let input = 50504
        let result = "아"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    
    func test_removeWord호출시_와_입력시_오반환되는지() {
        let input = 50752
        let result = "오"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_워_입력시_우반환되는지() {
        let input = 50892
        let result = "우"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_위_입력시_우반환되는지() {
        let input = 50948
        let result = "우"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_왜_입력시_오반환되는지() {
        let input = 50780
        let result = "오"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_웨_입력시_우반환되는지() {
        let input = 50920
        let result = "우"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_외_입력시_오반환되는지() {
        let input = 50808
        let result = "오"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_에_입력시_ㅇ반환되는지() {
        let input = 50640
        let result = "ㅇ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }
    func test_removeWord호출시_예_입력시_ㅇ반환되는지() {
        let input = 50696
        let result = "ㅇ"
        
        XCTAssertEqual(sut?.removeWord(lastUniCode: input), result)
    }

}
