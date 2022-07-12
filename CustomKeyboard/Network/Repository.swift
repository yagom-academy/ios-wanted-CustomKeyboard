//
//  Repository.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import Foundation

class Repository {
    private let httpClient = HttpClient(baseUrl: "https://api.plkey.app/theme/review")
    
    func reviewData(completion: @escaping(Data) -> Void) {
        httpClient.getJson(path: "", params: "", completed: <#T##(Result<String, Error>) -> Void#>)
    }
}
