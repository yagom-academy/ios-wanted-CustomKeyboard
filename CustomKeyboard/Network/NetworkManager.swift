//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/12.
//

import Foundation

enum CustomError: Error {
    case makeURL
    case loadError
    case noData
    var description: String {
        switch self {
        case .makeURL:
            return "URL 에러"
        case .loadError:
            return "로드 에러"
        case .noData:
            return "데이터가 없습니다."
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private let api = NetworkAPI()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchReview(completion: @escaping (Result<ReviewTypes, CustomError>) -> ()) {
        guard let url = api.getGetReviewAPI().url else {
            completion(.failure(CustomError.makeURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(CustomError.loadError))
                return
            }
            guard let data = data else {
                print(URLError.dataNotAllowed)
                completion(.failure(CustomError.noData))
                return
            }
            do {
                let hasData = try JSONDecoder().decode(ReviewTypes.self, from: data)
                completion(.success(hasData))
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func postReview(message: String) {
        struct PostData: Codable {
            var content: String
        }
        guard let url = api.getPostReviewAPI().url else {
            return print(URLError.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let jsonData = try? JSONEncoder().encode(PostData(content: message)) else {
            print("encoding Error")
            return
        }
        request.httpBody = jsonData
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print(URLError.badServerResponse)
                return
            }
            guard let data = data else {
                print(URLError.dataNotAllowed)
                return
            }
            do {
                let hadData = try JSONDecoder().decode(ReviewTypes.self, from: data)
                print(hadData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
