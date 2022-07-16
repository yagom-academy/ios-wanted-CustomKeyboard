//
//  KeyBoardEngineTest_kirkim.swift
//  KeyBoardEngineTest_kirkim
//
//  Created by 김기림 on 2022/07/15.
//

import XCTest
@testable import CustomKeyboard

class KeyBoardEngine_addWord_Test_kirkim: XCTestCase {
    let consonant: [String:Int] = ["ㄱ":12593,"ㄲ":12594,"ㄴ":12596,"ㄷ":12599,"ㄸ":12600,"ㄹ":12601,"ㅁ":12609,"ㅂ":12610,"ㅃ":12611,"ㅅ":12613,"ㅆ":12614,"ㅇ":12615,"ㅈ":12616,"ㅉ":12617,"ㅊ":12618,"ㅋ":12619,"ㅌ":12620,"ㅍ":12621,"ㅎ":12622]
    let vowel: [String:Int] = ["ㅏ":12623,"ㅐ":12624,"ㅑ":12625,"ㅒ":12626,"ㅓ":12627,"ㅔ":12628,"ㅕ":12629,"ㅖ":12630,"ㅗ":12631,"ㅘ":12632,"ㅙ":12633,"ㅚ":12634,"ㅛ":12635,"ㅜ":12636,"ㅝ":12637,"ㅞ":12638,"ㅟ":12639,"ㅠ":12640,"ㅡ":12641,"ㅢ":12642,"ㅣ":12643]
    let special: [String:Int] = ["각":44033,"간":44036,"갈":44040,"갑":44049,"가":44032]
    var sut:KeyBoardEngine?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FirstKeyBoardEngine()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_addWord호출시_ㅂ_ㅂ_입력시_ㅃ가반환되는지() {
        let input1 = 12610
        let input2 = 12610
        let result = "ㅃ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅈ_ㅈ_입력시_ㅉ가반환되는지() {
        let input1 = 12616
        let input2 = 12616
        let result = "ㅉ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㄷ_ㄷ_입력시_ㄸ가반환되는지() {
        let input1 = 12599
        let input2 = 12599
        let result = "ㄸ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }

    func test_addWord호출시_ㄱ_ㄱ_입력시_ㄲ가반환되는지() {
        let input1 = 12593
        let input2 = 12593
        let result = "ㄲ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅅ_ㅅ_입력시_ㅆ가반환되는지() {
        let input1 = 12613
        let input2 = 12613
        let result = "ㅆ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅓ_ㅣ_입력시_ㅔ가반환되는지() {
        let input1 = 12627
        let input2 = 12643
        let result = "ㅔ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅏ_ㅣ_입력시_ㅐ가반환되는지() {
        let input1 = 12623
        let input2 = 12643
        let result = "ㅐ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅑ_ㅣ_입력시_ㅒ가반환되는지() {
        let input1 = 12625
        let input2 = 12643
        let result = "ㅒ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅕ_ㅣ_입력시_ㅖ가반환되는지() {
        let input1 = 12623
        let input2 = 12643
        let result = "ㅖ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅗ_ㅏ_입력시_ㅘ가반환되는지() {
        let input1 = 12631
        let input2 = 12623
        let result = "ㅘ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅗ_ㅣ_입력시_ㅚ가반환되는지() {
        let input1 = 12631
        let input2 = 12643
        let result = "ㅚ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅗ_ㅐ_입력시_ㅙ가반환되는지() {
        let input1 = 12631
        let input2 = 12624
        let result = "ㅙ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅜ_ㅣ_입력시_ㅟ가반환되는지() {
        let input1 = 12636
        let input2 = 12643
        let result = "ㅟ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅜ_ㅔ_입력시_ㅞ가반환되는지() {
        let input1 = 12636
        let input2 = 12628
        let result = "ㅞ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_ㅡ_ㅣ_입력시_ㅢ가반환되는지() {
        let input1 = 12641
        let input2 = 12643
        let result = "ㅢ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_각_ㅅ_입력시_갃반환되는지() {
        let input1 = 44033
        let input2 = 12613
        let result = "갃"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_간_ㅈ_입력시_갅반환되는지() {
        let input1 = 44036
        let input2 = 12616
        let result = "갅"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_간_ㅎ_입력시_갆반환되는지() {
        let input1 = 44036
        let input2 = 12622
        let result = "갆"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㄱ_입력시_갉반환되는지() {
        let input1 = 44040
        let input2 = 12593
        let result = "갉"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㅁ_입력시_갊반환되는지() {
        let input1 = 44040
        let input2 = 12609
        let result = "갊"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㅂ_입력시_갋반환되는지() {
        let input1 = 44040
        let input2 = 12610
        let result = "갋"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㅅ_입력시_갌반환되는지() {
        let input1 = 44040
        let input2 = 12613
        let result = "갌"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㅌ_입력시_갍반환되는지() {
        let input1 = 44040
        let input2 = 12620
        let result = "갍"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㅍ_입력시_갎반환되는지() {
        let input1 = 44040
        let input2 = 12621
        let result = "갎"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갈_ㅎ_입력시_갏반환되는지() {
        let input1 = 44040
        let input2 = 12622
        let result = "갏"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_갑_ㅅ_입력시_값반환되는지() {
        let input1 = 44049
        let input2 = 12613
        let result = "값"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    
    func test_addWord호출시_가_ㄱ_입력시_각반환되는지() {
        let input1 = 44032
        let input2 = 12593
        let result = "각"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㄲ_입력시_갂반환되는지() {
        let input1 = 44032
        let input2 = 12594
        let result = "갂"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㄴ_입력시_간반환되는지() {
        let input1 = 44032
        let input2 = 12596
        let result = "간"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㄷ_입력시_갇반환되는지() {
        let input1 = 44032
        let input2 = 12599
        let result = "갇"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㄹ_입력시_갈반환되는지() {
        let input1 = 44032
        let input2 = 12601
        let result = "갈"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅁ_입력시_감반환되는지() {
        let input1 = 44032
        let input2 = 12609
        let result = "감"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅂ_입력시_갑반환되는지() {
        let input1 = 44032
        let input2 = 12610
        let result = "갑"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅅ_입력시_갓반환되는지() {
        let input1 = 44032
        let input2 = 12613
        let result = "갓"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅆ_입력시_갔반환되는지() {
        let input1 = 44032
        let input2 = 12614
        let result = "갔"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅇ_입력시_강반환되는지() {
        let input1 = 44032
        let input2 = 12615
        let result = "강"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅈ_입력시_갖반환되는지() {
        let input1 = 44032
        let input2 = 12616
        let result = "갖"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅊ_입력시_갗반환되는지() {
        let input1 = 44032
        let input2 = 12618
        let result = "갗"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅋ_입력시_갘반환되는지() {
        let input1 = 44032
        let input2 = 12619
        let result = "갘"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅌ_입력시_같반환되는지() {
        let input1 = 44032
        let input2 = 12620
        let result = "같"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅍ_입력시_갚반환되는지() {
        let input1 = 44032
        let input2 = 12621
        let result = "갚"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
    func test_addWord호출시_가_ㅎ_입력시_갛반환되는지() {
        let input1 = 44032
        let input2 = 12622
        let result = "갛"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input1, lastUniCode: input2), result)
    }
}
