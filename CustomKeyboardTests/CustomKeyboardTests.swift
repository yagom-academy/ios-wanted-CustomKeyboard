//
//  CustomKeyboardTests.swift
//  CustomKeyboardTests
//
//  Created by 이경민 on 2022/07/15.
//

import XCTest
@testable import CustomKeyboard

class CustomKeyboardTests: XCTestCase {
    var viewModel: KeyboardViewModel!
    
    override func setUpWithError() throws {
        viewModel = KeyboardViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_입력() {
        let expected = "헤일못별빛이이런하나의내일봅니다써라이너새워때이름과잠이런위에있습니다별시와사람들의차이름을너무나아직까닭입니다시와내일아침이밤이있습니다남은너무나이런있습니다흙으로풀이이름을많은사람들의불러나의지나가는위에도봅니다별들을딴은추억과아직별빛이어머님파란봅니다"
        
        let compats: [Compatibility] = [
            .ㅎ, .ㅔ, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅅ, .ㅂ, .ㅕ, .ㄹ, .ㅂ, .ㅣ, .ㅊ, .ㅇ, .ㅣ, .ㅇ, .ㅣ, .ㄹ, .ㅓ, .ㄴ, .ㅎ, .ㅏ, .ㄴ, .ㅏ, .ㅇ, .ㅢ, .ㄴ, .ㅐ, .ㅇ, .ㅣ, .ㄹ, .ㅂ, .ㅗ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ, .ㅆ, .ㅓ, .ㄹ, .ㅏ, .ㅇ, .ㅣ, .ㄴ, .ㅓ, .ㅅ, .ㅐ, .ㅇ, .ㅝ, .ㄸ, .ㅐ, .ㅇ, .ㅣ, .ㄹ, .ㅡ, .ㅁ, .ㄱ, .ㅘ, .ㅈ, .ㅏ, .ㅁ, .ㅇ, .ㅣ, .ㄹ, .ㅓ, .ㄴ, .ㅇ, .ㅟ, .ㅇ, .ㅔ, .ㅇ, .ㅣ, .ㅆ, .ㅅ, .ㅡ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ, .ㅂ, .ㅕ, .ㄹ, .ㅅ, .ㅣ, .ㅇ, .ㅘ, .ㅅ, .ㅏ, .ㄹ, .ㅏ, .ㅁ, .ㄷ, .ㅡ, .ㄹ, .ㅇ, .ㅢ, .ㅊ, .ㅏ, .ㅇ, .ㅣ, .ㄹ, .ㅡ, .ㅁ, .ㅇ, .ㅡ, .ㄹ, .ㄴ, .ㅓ, .ㅁ, .ㅜ, .ㄴ, .ㅏ, .ㅇ, .ㅏ, .ㅈ, .ㅣ, .ㄱ, .ㄲ, .ㅏ, .ㄷ, .ㅏ, .ㄹ, .ㄱ, .ㅇ, .ㅣ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ, .ㅅ, .ㅣ, .ㅇ, .ㅘ, .ㄴ, .ㅐ, .ㅇ, .ㅣ, .ㄹ, .ㅇ, .ㅏ, .ㅊ, .ㅣ, .ㅁ, .ㅇ, .ㅣ, .ㅂ, .ㅏ, .ㅁ, .ㅇ, .ㅣ, .ㅇ, .ㅣ, .ㅆ, .ㅅ, .ㅡ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ, .ㄴ, .ㅏ, .ㅁ, .ㅇ, .ㅡ, .ㄴ, .ㄴ, .ㅓ, .ㅁ, .ㅜ, .ㄴ, .ㅏ, .ㅇ, .ㅣ, .ㄹ, .ㅓ, .ㄴ, .ㅇ, .ㅣ, .ㅆ, .ㅅ, .ㅡ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ, .ㅎ, .ㅡ, .ㄹ, .ㄱ, .ㅇ, .ㅡ, .ㄹ, .ㅗ, .ㅍ, .ㅜ, .ㄹ, .ㅇ, .ㅣ, .ㅇ, .ㅣ, .ㄹ, .ㅡ, .ㅁ, .ㅇ, .ㅡ, .ㄹ, .ㅁ, .ㅏ, .ㄴ, .ㅎ, .ㅇ, .ㅡ, .ㄴ, .ㅅ, .ㅏ, .ㄹ, .ㅏ, .ㅁ, .ㄷ, .ㅡ, .ㄹ, .ㅇ, .ㅢ, .ㅂ, .ㅜ, .ㄹ, .ㄹ, .ㅓ, .ㄴ, .ㅏ, .ㅇ, .ㅢ, .ㅈ, .ㅣ, .ㄴ, .ㅏ, .ㄱ, .ㅏ, .ㄴ, .ㅡ, .ㄴ, .ㅇ, .ㅟ, .ㅇ, .ㅔ, .ㄷ, .ㅗ, .ㅂ, .ㅗ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ, .ㅂ, .ㅕ, .ㄹ, .ㄷ, .ㅡ, .ㄹ, .ㅇ, .ㅡ, .ㄹ, .ㄸ, .ㅏ, .ㄴ, .ㅇ, .ㅡ, .ㄴ, .ㅊ, .ㅜ, .ㅇ, .ㅓ, .ㄱ, .ㄱ, .ㅘ, .ㅇ, .ㅏ, .ㅈ, .ㅣ, .ㄱ, .ㅂ, .ㅕ, .ㄹ, .ㅂ, .ㅣ, .ㅊ, .ㅇ, .ㅣ, .ㅇ, .ㅓ, .ㅁ, .ㅓ, .ㄴ, .ㅣ, .ㅁ, .ㅍ, .ㅏ, .ㄹ, .ㅏ, .ㄴ, .ㅂ, .ㅗ, .ㅂ, .ㄴ, .ㅣ, .ㄷ, .ㅏ,

        ]
        
        compats.forEach {
            viewModel.didTapKeyboardButton(buffer: $0)
        }
        
        XCTAssertEqual(expected, viewModel.result.value)
    }
    
    // 스페이스
    func test_한칸띄어쓰기() {
        viewModel.result.value = "헤일못"
        
        viewModel.addSpace()
        
        let expect = "헤일못 "
        XCTAssertEqual(expect, viewModel.result.value)
    }
    
    // 지우는 것
    func test_지우기() {
        let compats: [Compatibility] = [.ㅎ, .ㅔ, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅂ, .ㅅ]
        
        compats.forEach { value in
            viewModel.didTapKeyboardButton(buffer: value)
        }
        
        (0..<3).forEach { _ in
            viewModel.didTapBack()
        }
        
        let expect = "헤일ㅁ"
        XCTAssertEqual(expect, viewModel.result.value)
    }
    
    func test_띄어쓰기가마지막에있는텍스트지우기() {
        let compats: [Compatibility] = [.ㅎ, .ㅔ, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅂ, .ㅅ]
        
        compats.forEach { value in
            viewModel.didTapKeyboardButton(buffer: value)
        }
        viewModel.addSpace()
        
        let expect = 4
        var resultCount = 0
        while !viewModel.result.value.isEmpty {
            viewModel.didTapBack()
            resultCount += 1
        }
        
        XCTAssertEqual(expect, resultCount)
    }
    

    
    func test_띄어쓰기가중간에있는텍스트지우기() {
        let compats: [Compatibility?] = [.ㅎ, .ㅔ, nil, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅂ, .ㅅ]
        
        compats.forEach { value in
            if let compat = value{
                viewModel.didTapKeyboardButton(buffer: compat)
            } else {
                viewModel.addSpace()
            }
            // 헤 일몺
        }
        
        let expect = 9
        var resultCount = 0
        while !viewModel.result.value.isEmpty {
            viewModel.didTapBack()
            resultCount += 1
        }
        
        XCTAssertEqual(expect, resultCount)
    }
    
    func test_마지막을지웠다가다시적었을경우() { // 헤일못 -> 헤일몺
        let compats: [Compatibility] = [.ㅎ, .ㅔ, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅅ]
        let afterCompats: [Compatibility] = [.ㅂ, .ㅅ]
        compats.forEach { value in
            viewModel.didTapKeyboardButton(buffer: value) // 헤일못
        }
        
        viewModel.didTapBack()
        
        afterCompats.forEach { value in
            viewModel.didTapKeyboardButton(buffer: value) // 헤일몺
        }
        let expect = "헤일몺"
        
        XCTAssertEqual(expect, viewModel.result.value)
    }
    
    // 헤일못
    func test_마지막스페이스를지우고다시작성하는경우() {
        let compats: [Compatibility] = [.ㅎ, .ㅔ, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅅ]
        compats.forEach { value in
            viewModel.didTapKeyboardButton(buffer: value)
        }
        
        viewModel.addSpace() // 헤일못" "
        viewModel.didTapBack() // 헤일못
        
        viewModel.didTapKeyboardButton(buffer: .ㄱ)
        
        let expect = "헤일못ㄱ"
        
        XCTAssertEqual(expect, viewModel.result.value)
    }
    
    func test_마지막스페이스를지우고다시작성히하는데이중모음이가능한경우() { // 헤일몹" " => 헤일몹ㅅ
        let compats: [Compatibility] = [.ㅎ, .ㅔ, .ㅇ, .ㅣ, .ㄹ, .ㅁ, .ㅗ, .ㅂ]
        
        compats.forEach { value in
            viewModel.didTapKeyboardButton(buffer: value)
        }
        
        viewModel.addSpace()
        viewModel.didTapBack()
        
        viewModel.didTapKeyboardButton(buffer: .ㅅ)
        let expect = "헤일몹ㅅ"
        
        XCTAssertEqual(expect, viewModel.result.value)
    }
}
