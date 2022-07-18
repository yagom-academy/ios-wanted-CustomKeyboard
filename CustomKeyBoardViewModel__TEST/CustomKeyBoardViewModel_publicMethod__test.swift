//
//  CustomKeyBoardViewModel_publicMethod__test.swift
//  CustomKeyBoardViewModelTest_kirkim
//
//  Created by 김기림 on 2022/07/18.
//

import XCTest
@testable import CustomKeyboard

class CustomKeyBoardViewModel_publicMethod__test: XCTestCase {
    var sut: CustomKeyBoardViewModel?
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CustomKeyBoardViewModel(engine: FirstKeyBoardEngine())
    }

    override func tearDownWithError() throws {
        try super.setUpWithError()
        sut = nil
    }

    func test_addSpace호출시_공백에_띄어쓰기반환되는지() {
        let beforeText = ""
        let result = " "
        
        XCTAssertEqual(sut?.addSpace(to:beforeText), result)
    }
    
    func test_addSpace호출시_가나에_띄어쓰기반환되는지() {
        let beforeText = "가나"
        let result = "가나 "
        
        XCTAssertEqual(sut?.addSpace(to:beforeText), result)
    }

    func test_addWord호출시_빈문자열에_ㄱ_입력시_ㄱ반환되는지() {
        let beforeText = ""
        let input = 12593
        let result = "ㄱ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input, to: beforeText), result)
    }
    func test_addWord호출시_한글자에_ㄱ_입력시_한글자ㄱ반환되는지() {
        let beforeText = "생"
        let input = 12593
        let result = "생ㄱ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input, to: beforeText), result)
    }
    func test_addWord호출시_두글자에_ㄱ_입력시_한글자ㄱ반환되는지() {
        let beforeText = "생생"
        let input = 12593
        let result = "생생ㄱ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input, to: beforeText), result)
    }
    func test_addWord호출시_긴문장에_ㅐ_입력시_긴문자ㅐ반환되는지() {
        let beforeText = "스위프트(영어: Swift)는 애플의 iOS와 macOS를 위한 프로그래밍 언어로 2014년 6월 2일 애플 세계 개발자 회의(WWDC)에서 처음 소개되었다.[3] 스위프트 언어의 문법은 파이썬 언어라고 발표 초창기에 알려졌었다. 기존의 애플 운영체제용 언어인 오브젝티브-C와 함께 사용할 목적으로 만들어졌다. 오브젝티브-C와 마찬가지로 LLVM으로 빌드되고 같은 런타임을 공유한다. 클로저, 다중 리턴 타입, 네임스페이스, 제네릭스, 타입 유추 등 오브젝티브-C에는 없었던 현대 프로그래밍 언어가 갖고 있는 기능을 많이 포함시켰으며 코드 내부에서 C나 오브젝티브-C 코드를 섞어서 프로그래밍하거나 스크립트 언어처럼 실시간으로 상호작용하며 프로그래밍 할 수도 있다.[4] 언어 설명서도 함께 배포되었다. 애플에서는 iBooks에서 Swift에 관한 책을 배포하고 있다. 2.0버전에서 3.0버전이 나오며 많은 C 형식의 for문이 삭제되고 ++,--연산자가 삭제되는 등 많은 변경이 되어 하위호환이 안된다. [5] Xcode에서 사용 가능하다.출처 위키백과"
        let input = 12624
        let result = "스위프트(영어: Swift)는 애플의 iOS와 macOS를 위한 프로그래밍 언어로 2014년 6월 2일 애플 세계 개발자 회의(WWDC)에서 처음 소개되었다.[3] 스위프트 언어의 문법은 파이썬 언어라고 발표 초창기에 알려졌었다. 기존의 애플 운영체제용 언어인 오브젝티브-C와 함께 사용할 목적으로 만들어졌다. 오브젝티브-C와 마찬가지로 LLVM으로 빌드되고 같은 런타임을 공유한다. 클로저, 다중 리턴 타입, 네임스페이스, 제네릭스, 타입 유추 등 오브젝티브-C에는 없었던 현대 프로그래밍 언어가 갖고 있는 기능을 많이 포함시켰으며 코드 내부에서 C나 오브젝티브-C 코드를 섞어서 프로그래밍하거나 스크립트 언어처럼 실시간으로 상호작용하며 프로그래밍 할 수도 있다.[4] 언어 설명서도 함께 배포되었다. 애플에서는 iBooks에서 Swift에 관한 책을 배포하고 있다. 2.0버전에서 3.0버전이 나오며 많은 C 형식의 for문이 삭제되고 ++,--연산자가 삭제되는 등 많은 변경이 되어 하위호환이 안된다. [5] Xcode에서 사용 가능하다.출처 위키백과ㅐ"
        
        XCTAssertEqual(sut?.addWord(inputUniCode: input, to: beforeText), result)
    }
    
    func test_removeWord호출시_빈문자열에_공백반환되는지() {
        let beforeText = ""
        let result = ""
        
        XCTAssertEqual(sut?.removeWord(from: beforeText), result)
    }
    
    func test_removeWord호출시_끝이빈문자열인문장에_공백만지워져서반환되는지() {
        let beforeText = "가나다라마 "
        let result = "가나다라마"
        
        XCTAssertEqual(sut?.removeWord(from: beforeText), result)
    }
    
    func test_removeWord호출시_끝에빈문자열이2개인문장에_맨끝공백만지워져서반환되는지() {
        let beforeText = "가나다라마  "
        let result = "가나다라마 "
        
        XCTAssertEqual(sut?.removeWord(from: beforeText), result)
    }
    
    func test_removeWord호출시_긴문장에_끝글자만잘지워져서반환되는지() {
        let beforeText = "스위프트(영어: Swift)는 애플의 iOS와 macOS를 위한 프로그래밍 언어로 2014년 6월 2일 애플 세계 개발자 회의(WWDC)에서 처음 소개되었다.[3] 스위프트 언어의 문법은 파이썬 언어라고 발표 초창기에 알려졌었다. 기존의 애플 운영체제용 언어인 오브젝티브-C와 함께 사용할 목적으로 만들어졌다. 오브젝티브-C와 마찬가지로 LLVM으로 빌드되고 같은 런타임을 공유한다. 클로저, 다중 리턴 타입, 네임스페이스, 제네릭스, 타입 유추 등 오브젝티브-C에는 없었던 현대 프로그래밍 언어가 갖고 있는 기능을 많이 포함시켰으며 코드 내부에서 C나 오브젝티브-C 코드를 섞어서 프로그래밍하거나 스크립트 언어처럼 실시간으로 상호작용하며 프로그래밍 할 수도 있다.[4] 언어 설명서도 함께 배포되었다. 애플에서는 iBooks에서 Swift에 관한 책을 배포하고 있다. 2.0버전에서 3.0버전이 나오며 많은 C 형식의 for문이 삭제되고 ++,--연산자가 삭제되는 등 많은 변경이 되어 하위호환이 안된다. [5] Xcode에서 사용 가능하다.출처 위키백과"
        let result = "스위프트(영어: Swift)는 애플의 iOS와 macOS를 위한 프로그래밍 언어로 2014년 6월 2일 애플 세계 개발자 회의(WWDC)에서 처음 소개되었다.[3] 스위프트 언어의 문법은 파이썬 언어라고 발표 초창기에 알려졌었다. 기존의 애플 운영체제용 언어인 오브젝티브-C와 함께 사용할 목적으로 만들어졌다. 오브젝티브-C와 마찬가지로 LLVM으로 빌드되고 같은 런타임을 공유한다. 클로저, 다중 리턴 타입, 네임스페이스, 제네릭스, 타입 유추 등 오브젝티브-C에는 없었던 현대 프로그래밍 언어가 갖고 있는 기능을 많이 포함시켰으며 코드 내부에서 C나 오브젝티브-C 코드를 섞어서 프로그래밍하거나 스크립트 언어처럼 실시간으로 상호작용하며 프로그래밍 할 수도 있다.[4] 언어 설명서도 함께 배포되었다. 애플에서는 iBooks에서 Swift에 관한 책을 배포하고 있다. 2.0버전에서 3.0버전이 나오며 많은 C 형식의 for문이 삭제되고 ++,--연산자가 삭제되는 등 많은 변경이 되어 하위호환이 안된다. [5] Xcode에서 사용 가능하다.출처 위키백고"
        
        XCTAssertEqual(sut?.removeWord(from: beforeText), result)
    }
}
