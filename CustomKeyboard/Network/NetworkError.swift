//
//  NetworkError.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/20.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case decodeError
    case invalidURL
    case invalidData
    case networkError(Error)
    case unknownError
}

enum SevericeError: Error {
    case noReponseError
}
