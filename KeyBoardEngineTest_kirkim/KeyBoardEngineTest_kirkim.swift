//
//  KeyBoardEngineTest_kirkim.swift
//  KeyBoardEngineTest_kirkim
//
//  Created by 김기림 on 2022/07/15.
//

import XCTest
@testable import CustomKeyboard

class KeyBoardEngineTest_kirkim: XCTestCase {
    var sut:KeyBoardEngine?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FirstKeyBoardEngine()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    
}
