//
//  NetworkService.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/13.
//

import Foundation

enum HttpMethod {
    case get
    case post
}

protocol Api{
    func request(httpMethod: HttpMethod, condent: String, completion: @escaping (Result<Codable?, Error>)->())
}

class NetworkService: Api{
    func request(httpMethod: HttpMethod, condent: String, completion: @escaping (Result<Codable?, Error>)->()){
        switch httpMethod {
        case .get:
            getRequest { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .post:
            postRequest(condent: condent) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    private func getRequest(completion: @escaping (Result<Codable?, Error>)->()){
        let urlString = "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20"
        guard let url = URL(string: urlString) else { return }
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200..<300).contains(statusCode), let data = data else {
                completion(.failure(error!))
                return
            }
            do{
                let resultData = try JSONDecoder().decode(ReviewListModel.self, from: data)
                print(">>>>>>get>>>>>>>Success")
                completion(.success(resultData))
            }catch{
                completion(.failure(error))
                return
            }
        }
        dataTask.resume()
    }
}
    private func postRequest(condent: String, completion: @escaping (Result<Int, Error>)->()){
        let data: [String:String] = ["content":condent]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        
        let urlString = "https://api.plkey.app/tmp/theme/PLKEY0-L-81/review"
        guard let url = URL(string: urlString) else { return }
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.httpBody = jsonData

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
                completion(.failure(error!))
                return
            }
            print(">>>>>statusCode: ", statusCode)
            completion(.success(statusCode))
        }
        dataTask.resume()
}

