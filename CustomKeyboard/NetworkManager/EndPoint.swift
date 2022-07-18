//
//  EndPoint.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/16.
//

import Foundation
import UIKit

protocol NetworkErrorReceivable {
    func getNetworkErrorMessage(error: Error)
}

class EndPoint {
    var delegate: NetworkErrorReceivable?
    var baseURL: URL? = nil
    var path: String? = ""
    var getRequest: GetRequest = GetRequest()
    
    init(){
        getRequest = GetRequest()
    }
    
    func getReview(completion: @escaping (Result<Data1, Error>) -> Void) {
        getRequest.method = .GET
        Repository().getReviewData(request: getRequest) { result in
            switch result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//protocol Endpoint {
//    var scheme: String { get }
//    var host: String { get }
//    var path: String { get }
//    var method: RequestMethod { get }
//    var header: [String: String]? { get }
//    var body: [String: String]? { get }
//}
//
//extension Endpoint {
//    var scheme: String {
//        return "https"
//    }
//
//    var host: String {
//        return "api.plkey.app"
//    }
//}

//enum RequestMethod: String {
//    case get = "GET"
//    case post = "POST"
//}
//
//enum RequestError: Error {
//    case decode
//    case invalidURL
//    case noResponse
//    case unexpectedStatusCode
//    case unknown
//}
//
//protocol HTTPClient {
//    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
//}
