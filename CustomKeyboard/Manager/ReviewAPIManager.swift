//
//  ReviewAPIManager.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

class ReviewAPIManager {
    static let shared = ReviewAPIManager()
    
    func getReview(_ completion: @escaping ((ReviewData) -> Void)) {
        guard let url = URL(string: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") else {
            print("URL Error")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let data = data,
                  let res = response as? HTTPURLResponse else {
                print("URLSession Datatask Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let reviews = try JSONDecoder().decode(ReviewData.self, from: data)
                completion(reviews)
            } catch let parsingError {
                print("Parsing Error: \(parsingError)")
            }
        }
        dataTask.resume()
    }
    
    func postReview() {
        
    }
}
