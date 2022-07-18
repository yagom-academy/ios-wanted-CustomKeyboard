//
//  NetworkManager.swift
//  CustomKeyboard
//
//

import Foundation


struct constantURL {
    static let getURL = "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20"
    static let postURL = "https://api.plkey.app/tmp/theme/PLKEY0-L-81/review"
}

enum NetworkError: Error {
    case noInternet
    case decodeError
    case invalidURL
    case invalidData
    case networkError(Error)
    case unknownError
}

enum SevericeError: Error {
    case noReponseError
}



enum ServiceMethod: String {
    case GET
    case POST
}

protocol Service {
    var header: [String : String]? { get }
    var body: [String : String]? { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var getUrlRequest: URLRequest? {
        let components = URLComponents(string: constantURL.getURL)
        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    public var postUrlRequest: URLRequest? {
        let components = URLComponents(string: constantURL.postURL)
        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        return request
    }
}

class GetRequest: Service {
    var header: [String : String]?
    var body: [String : String]?
    var method: ServiceMethod = .GET
}

class GetReviewData {
    func getReviewList(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let getTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.networkError(error)))
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            guard 200..<300 ~= httpResponse.statusCode else { completion(.failure(SevericeError.noReponseError))
                return
            }
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.invalidData))
            }
        }
        getTask.resume()
    }
}

