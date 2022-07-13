//
//  ReviewRepository.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/12.
//

import Foundation

final class ReviewRepository {
  
  private let network: NetworkServiceable
  private var imageCache = NSCache<NSURL,NSData>()
  
  init(network: NetworkService = NetworkService()){
    self.network = network
  }
  
  func fetchReviews(endPoint: EndPoint, completion: @escaping (Result<[Review], Error>) -> Void) {
    let URLRequest = URLRequest.makeURLRequest(request: Requset(requestType: .get, endPoint: endPoint))
    network.request(on: URLRequest) { result in
      var reviews: [Review] = []
      switch result {
      case .success(let data):
        guard let reviewResponse = Decoder<ReviewResponse>().decode(data: data) else {return}
        reviewResponse.data.forEach({
          reviews.append($0.toDomain())
        })
        completion(.success(reviews))
      case .failure(let error):
        completion(.failure(error))
        print(error)
      }
    }
  }
  
  func loadImage(url:URL, completion: @escaping (Result<Data,Error>) -> Void) {
    if let data = imageCache.object(forKey: url as NSURL) {
      completion(.success(data as Data))
      return
    }
    
    let URLRequest = URLRequest(url: url)
    network.request(on: URLRequest) {[weak self] result in
      switch result{
      case .success(let data):
        completion(.success(data))
        self?.imageCache.setObject(data as NSData, forKey: url as NSURL)
      case .failure(let error):
        completion(.failure(error))
        print(error)
      }
    }
  }
  
  func postReview(endPoint: EndPoint, body: Comment, completion: @escaping (Result<Bool,Error>) -> Void) {
    guard let commentData = Encoder<Comment>().encode(model: body) else {return}
    let URLRequest = URLRequest.makeURLRequest(request: Requset(requestType: .post, body: commentData, endPoint: endPoint))
    network.request(on: URLRequest) { result in
      switch result {
      case .success(let data):
        completion(.success(true))
      case .failure(let error):
        completion(.failure(error))
      }
    }
    
    
    
  }
  
}
