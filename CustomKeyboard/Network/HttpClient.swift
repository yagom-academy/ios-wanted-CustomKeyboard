//
//  HttpClient.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import Foundation

class HttpClient {
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func getJson(completed: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let queryParams = params.map { k, v in "\(k)=\(v)" }.joined(separator: "&")

            var fullPath = path.hasPrefix("http") ? path : self.baseUrl + path
            if !queryParams.isEmpty {
                fullPath += "?" + queryParams
            }

            do {
                let url = URL(string: fullPath)
                let json = try String(contentsOf: url!, encoding: .utf8)
                DispatchQueue.main.async {
                    completed(Result.success(json))
                }
            } catch {
                DispatchQueue.main.async {
                    completed(Result.failure(error))
                }
            }
        }
    }
}
