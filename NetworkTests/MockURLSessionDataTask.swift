//
//  MockURLSessionDataTask.swift
//  NetworkTests
//
//  Created by rae on 2022/07/21.
//

import Foundation
@testable import CustomKeyboard

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private let resumeHandler: () -> Void
    
    init(resumeHandler: @escaping () -> Void) {
        self.resumeHandler = resumeHandler
    }
    
    // 단순히 completionHandler 호출
    func resume() {
        resumeHandler()
    }
}
