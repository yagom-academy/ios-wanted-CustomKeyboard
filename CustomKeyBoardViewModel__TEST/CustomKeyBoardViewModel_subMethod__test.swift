//
//  CustomKeyBoardViewModelTest_kirkim.swift
//  CustomKeyBoardViewModelTest_kirkim
//
//  Created by 김기림 on 2022/07/15.
//

import XCTest
@testable import CustomKeyboard

class CustomKeyBoardViewModel_subMethod__test: XCTestCase {
    var sut: CustomKeyBoardViewModel?
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CustomKeyBoardViewModel(engine: FirstKeyBoardEngine())
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        sut = nil
    }

    func test_getLastCharUnicode호출시_공백입력했을때_nil반환되는지() {
        let input = ""
        
        XCTAssertNil(sut?.getLastCharUnicode(from: input))
    }
    
    func test_getLastCharUnicode호출시_가나쀍입력했을때_49165반환되는지() {
        let input = "가나쀍"
        let result = 49165
        
        XCTAssertEqual(sut?.getLastCharUnicode(from: input), result)
    }
    
    func test_getLastCharUnicode호출시_가나다ㅎ입력했을때_12622반환되는지() {
        let input = "가나다ㅎ"
        let result = 12622
        
        XCTAssertEqual(sut?.getLastCharUnicode(from: input), result)
    }
    
    func test_getLastCharUnicode호출시_매우긴문장ㄱ입력했을때_12593반환되는지() {
        let input = "테스트 주도 개발(Test-driven development TDD)[1]은 매우 짧은 개발 사이클을 반복하는 소프트웨어 개발 프로세스 중 하나이다. 개발자는 먼저 요구사항을 검증하는 자동화된 테스트 케이스를 작성한다. 그런 후에, 그 테스트 케이스를 통과하기 위한 최소한의 코드를 생성한다. 마지막으로 작성한 코드를 표준에 맞도록 리팩토링한다. 이 기법을 개발했거나 '재발견' 한 것으로 인정되는 Kent Beck은 2003년에 TDD가 단순한 설계를 장려하고 자신감을 불어넣어준다고 말하였다ㄱ"
        let result = 12593
        
        XCTAssertEqual(sut?.getLastCharUnicode(from: input), result)
    }
    
    func test_getLastCharUnicode호출시_공백각입력했을때_44033반환되는지() {
        let input = "     각"
        let result = 44033
        
        XCTAssertEqual(sut?.getLastCharUnicode(from: input), result)
    }
    
    func test_getLastCharUnicode호출시_ㅓ입력했을때_12627반환되는지() {
        let input = "ㅓ"
        let result = 12627
        
        XCTAssertEqual(sut?.getLastCharUnicode(from: input), result)
    }
    
    func test_getStringExceptLastChar호출시_공백입력했을때_nil반환되는지() {
        let input = ""
        
        XCTAssertNil(sut?.getStringExceptLastChar(from:input))
    }
    
    func test_getStringExceptLastChar호출시_가나다라마바사입력했을때_가나다라마바반환되는지() {
        let input = "가나다라마바사"
        let result = "가나다라마바"
        
        XCTAssertEqual(sut?.getStringExceptLastChar(from: input), result)
    }
    
    func test_getStringExceptLastChar호출시_가나다꿹입력했을때_가나다반환되는지() {
        let input = "가나다꿹"
        let result = "가나다"
        
        XCTAssertEqual(sut?.getStringExceptLastChar(from: input), result)
    }
    
    func test_getStringExceptLastChar호출시_팕입력했을때_공백반환되는지() {
        let input = "팕"
        let result = ""
        
        XCTAssertEqual(sut?.getStringExceptLastChar(from: input), result)
    }
    
    func test_getStringExceptLastChar호출시_가나ㅣ입력했을때_ㅣ반환되는지() {
        let input = "가나ㅣ"
        let result = "가나"
        
        XCTAssertEqual(sut?.getStringExceptLastChar(from: input), result)
    }
    
    func test_getStringExceptLastChar호출시_가나ㅎ입력했을때_ㅎ반환되는지() {
        let input = "가나ㅎ"
        let result = "가나"
        
        XCTAssertEqual(sut?.getStringExceptLastChar(from: input), result)
    }
    
    func test_getStringExceptLastChar호출시_매우긴문장햏입력했을때_매우긴문장반환되는지() {
        let input = "테스트 주도 개발(Test-driven development TDD)[1]은 매우 짧은 개발 사이클을 반복하는 소프트웨어 개발 프로세스 중 하나이다. 개발자는 먼저 요구사항을 검증하는 자동화된 테스트 케이스를 작성한다. 그런 후에, 그 테스트 케이스를 통과하기 위한 최소한의 코드를 생성한다. 마지막으로 작성한 코드를 표준에 맞도록 리팩토링한다. 이 기법을 개발했거나 '재발견' 한 것으로 인정되는 Kent Beck은 2003년에 TDD가 단순한 설계를 장려하고 자신감을 불어넣어준다고 말하였다.핡"
        let result = "테스트 주도 개발(Test-driven development TDD)[1]은 매우 짧은 개발 사이클을 반복하는 소프트웨어 개발 프로세스 중 하나이다. 개발자는 먼저 요구사항을 검증하는 자동화된 테스트 케이스를 작성한다. 그런 후에, 그 테스트 케이스를 통과하기 위한 최소한의 코드를 생성한다. 마지막으로 작성한 코드를 표준에 맞도록 리팩토링한다. 이 기법을 개발했거나 '재발견' 한 것으로 인정되는 Kent Beck은 2003년에 TDD가 단순한 설계를 장려하고 자신감을 불어넣어준다고 말하였다."
        
        XCTAssertEqual(sut?.getStringExceptLastChar(from: input), result)
    }
}
