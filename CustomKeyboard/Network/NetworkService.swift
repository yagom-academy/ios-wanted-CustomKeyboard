//
//  NetworkService.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/13.
//

import Foundation

protocol Api{
    
}

class NetworkService{
    func request(){
//        fetchListAll()
        postRequest()
    }
    private func fetchListAll(){
        let urlString = "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=2"
        guard let url = URL(string: urlString) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            let successsRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successsRange.contains(statusCode) else { return }
            guard let data = data else { return }
            do{
                let resultData = try JSONDecoder().decode(reviewList.self, from: data)
                print("success")
            }catch{
                print("ERROR: ", error)
            }
        }
        dataTask.resume()
    }
    private func postRequest(){
        let review = "Hello World"
        let data: [String:String] = ["content":review]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        
        let urlString = "https://api.plkey.app/tmp/theme/PLKEY0-L-81/review"
        guard let url = URL(string: urlString) else { return }
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.httpBody = jsonData

        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil else { return }
            let successsRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
            else { return }
            print(statusCode)
        }
        dataTask.resume()
    }
}
