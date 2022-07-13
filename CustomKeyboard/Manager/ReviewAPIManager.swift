//
//  ReviewAPIManager.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

class ReviewAPIManager {
    static let shared = ReviewAPIManager()
    
    func getReview() -> [Review] {
        var result: [Review] = []
        guard let url = URL(string: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") else {
            print("URL Error")
            return []
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let data = data,
                  let res = response as? HTTPURLResponse
                    // TODO: - JSON 데이터로 받아오면 Parsing
//                  let reviews = try? JSONDecoder().decode([Review].self, from: data)
            else {
                print("URLSession Datatask Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            print(res.statusCode)
//            result = reviews
        }
        
        dataTask.resume()
        
        return result
    }
    
    func postReview() {
        
    }
}
