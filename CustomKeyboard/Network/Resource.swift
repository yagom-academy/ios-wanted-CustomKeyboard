//
//  Resource.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/20.
//

import Foundation

struct Resource<T> {
    var urlRequest: URLRequest
    let parse: (Data) -> T?
}

extension Resource where T: Decodable {
    
    init(url: URL) {
        self.urlRequest = URLRequest(url: url)
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }

    init<Body: Encodable>(url: URL, parameters: [String: String], method: HttpMethod<Body>) {
        self.urlRequest = URLRequest(url: url)
        self.urlRequest.httpMethod = method.method
        
        switch method {
        case .post(let body):
            self.urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let reviewData = try? JSONEncoder().encode(body)
            self.urlRequest.httpBody = reviewData
        default: break
        }
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }
}
