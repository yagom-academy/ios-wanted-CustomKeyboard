//
//  CustomKeyboardAutomataTests.swift
//  CustomKeyboardAutomataTests
//
//  Created by CHUBBY on 2022/07/19.
//

import XCTest

class CustomKeyboardAutomataTests: XCTestCase {
    var hangulAutomata: HangulAutomata!
    
    
    override func setUpWithError() throws {
        hangulAutomata = HangulAutomata()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCompositHangul() throws {
        hangulAutomata.hangulAutomata(key: "ㄱ")
        hangulAutomata.hangulAutomata(key: "ㅏ")
        hangulAutomata.hangulAutomata(key: "ㅂ")
        hangulAutomata.hangulAutomata(key: "ㅅ")
        let buffer = hangulAutomata.buffer.reduce("") {
            $0 + $1
        }
        XCTAssertEqual("값", buffer)
    }
    
    func testDeleteHangul() {
        hangulAutomata.hangulAutomata(key: "ㄱ")
        hangulAutomata.hangulAutomata(key: "ㅏ")
        hangulAutomata.hangulAutomata(key: "ㅂ")
        hangulAutomata.hangulAutomata(key: "ㅅ")
        hangulAutomata.deleteBuffer()
        let buffer = hangulAutomata.buffer.reduce("") {
            $0 + $1
        }
        XCTAssertEqual("갑", buffer)
    }
    
    func testAutomataStatus() {
        hangulAutomata.hangulAutomata(key: "ㄱ")
        hangulAutomata.hangulAutomata(key: "ㅏ")
        hangulAutomata.hangulAutomata(key: "ㅂ")
        hangulAutomata.hangulAutomata(key: "ㅅ")
        let state = hangulAutomata.currentHangulState
        
        XCTAssertEqual(.dJongsung, state)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
