//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/11.
//

import Foundation

class NetworkManager {
    
    func downloadReview(closure : @escaping (ReviewList) -> Void) {
        guard let url = URL(string: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") else {return}

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {return}

            do {
              //받은 json데이터 파싱
                let result : ReviewList = try JSONDecoder().decode(ReviewList.self, from: data)
                closure(result)
            } catch(let e) {
                print(e)
            }
        }.resume()
    }
    
}
