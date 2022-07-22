//
//  SejongState.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/14.
//

import Foundation

/// 키보드 입력에 대해서 상태를 나타낸다.
///
/// - 현재까지 작성된 글자에 대해서 다음에 어떤 값이 입력 되어야 하는지, 현재 어떤 상태인지 나타낸다.
enum SejongState {
    /// 초성를 적어야 하는 상태
    case writeInitialState
    /// 중성을 적어야 하는 상태
    case writeMiddleState
    /// 종성을 적어야 하는 상태
    case writeLastState
    /// 홑받침을 이미 적은 상태
    case alreadyLastState
    /// 겹받침을 이미 적은 상태
    case alreadyDoubleLastState
}
