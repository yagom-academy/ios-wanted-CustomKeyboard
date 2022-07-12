//
//  CustomError.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import Foundation

enum CustomError: Error {
    case makeURLError
    case loadError
    case noData
    case decodingError
    case encodingError
    case responseError(code:Int)
    var description: String {
        switch self {
        case .makeURLError:
            return "URL 에러"
        case .loadError:
            return "로드 에러"
        case .noData:
            return "데이터가 없습니다."
        case .responseError(code: let code):
            return "리스폰에러 응답코드: \(code)"
        case .decodingError:
            return "디코딩 에러"
        case .encodingError:
            return "인코딩 에러"
        }
    }
}
