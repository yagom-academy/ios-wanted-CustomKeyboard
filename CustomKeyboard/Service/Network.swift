//
//  Network.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

//MARK: - NetworkError
enum NetworkError: String, Error {
    case invalidRequest
    case jsonError
    case serverError
    case unknown
    
    var description: String { self.rawValue }
}

struct Network {
    
    let path: String
    let parameters: [String: String]?
    
    init(path: String, parameters: [String: String]? = nil) {
        self.path = path
        self.parameters = parameters
    }
    
    func get(completion: @escaping (Result<[ReviewResult], NetworkError>) -> Void) {
    
        var urlComponents = URLComponents(string: path)
        urlComponents?.setQueryItems(with: parameters ?? [:])
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidRequest))
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.serverError))
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ReviewResponse.self, from: data)
                completion(.success(result.data))
            } catch {
                completion(.failure(.jsonError))
            }
        }.resume()
    }
    
    func post(_ comment: String, completionHandler: @escaping (Bool) -> Void) {
        let path = "https://api.plkey.app/tmp/theme/PLKEY0-L-81/review"
        let components = URLComponents(string: path)
        
        guard let url = components?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let value: [String:String] = [
            "content":comment
        ]
        
        do {
            let jsonData = try JSONEncoder().encode(value)
            request.httpBody = jsonData
        } catch {
            debugPrint(error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            debugPrint(String(data: data!, encoding: .utf8)!)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completionHandler(false)
                return
            }
            
            completionHandler(true)
        }.resume()
    }
}
