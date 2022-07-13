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

        let input = 0xAC00
        let expectation = [HG.fixed.top.kiyeok, HG.fixed.mid.a, HG.fixed.end.blank]
        let result = hangeulManager.getSeparatedCharacters(from: input, mode: 1)

        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 중성 에러")
        }

    }

    func testGetSeparatedCharacters2() throws {
        let input = 0xB2EC
        let expectation = [HG.fixed.top.digeud, HG.fixed.mid.a, HG.fixed.end.rieul]
        let result = hangeulManager.getSeparatedCharacters(from: input, mode: 1)

        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 중성 + 종성 에러")
        }

    }

    func testGetSeparatedCharacters3() throws {
        let input = 0xB8B8
        let expectation = [HG.fixed.top.rieul, HG.fixed.mid.oe, HG.fixed.end.rieul]
        let result = hangeulManager.getSeparatedCharacters(from: input, mode: 1)

        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 겹모음 + 종성 에러")
        }

    }

    func testGetSeparatedCharacters4() throws {
        let input = 0xB636
        let expectation = [HG.fixed.top.ssangDigeud, HG.fixed.mid.wa, HG.fixed.end.rieulMieum]
        let result = hangeulManager.getSeparatedCharacters(from: input, mode: 1)

        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 겹모음 + 겹받침 에러")
        }

    }

    func testGetSeparatedCharacters5() throws {
        let input = 0xC62D
        let expectation = [HG.fixed.top.ieung, HG.fixed.mid.o, HG.fixed.end.rieulKiyeok]
        let result = hangeulManager.getSeparatedCharacters(from: input, mode: 1)

        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 종성 + 겹받침 에러")
        }

    }

    func testGetSeparatedCharacters6() throws {
        let input = 0xC020
        let expectation = [HG.fixed.top.ssangBieub, HG.fixed.mid.wi, HG.fixed.end.blank]
        let result = hangeulManager.getSeparatedCharacters(from: input, mode: 1)

        for i in 0..<result.count {
            XCTAssertEqual(result[i], expectation[i], "초성 + 겹모음 에러")
        }

    }

}
