//
//  HomeViewModel.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/13.
//

import Foundation

final class HomeViewModel {
    
  var reviewList = Observable<[Review]>([])
  private let repository = ReviewRepository()
  
  subscript(indexPath: IndexPath) -> Review {
    return reviewList.value[indexPath.row]
  }
    
  func viewReviewList() {
    let endPoint = EndPoint(path: .showList)
    repository.fetchReviews(endPoint: endPoint) { [weak self] result in
      switch result {
      case .success(let reviews):
        self?.reviewList.value = reviews
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func showImage(url: URL, completion:@escaping (Data?) -> Void){
    repository.loadImage(url: url) { result in
      switch result {
      case .success(let data):
        completion(data)
      case .failure(let error):
        completion(nil)
        print(error)
      }
    }
  }
  
  func makeReview(review: String, completion:@escaping (Error?) -> Void){
    let endPoint = EndPoint(path: .postComment, queries: nil)
    repository.postReview(endPoint: endPoint, body: Comment(content: review)) { result in
      switch result {
      case .success(_):
        let mockReview = Review(id: "호잇",
                                user: User(id: "호이",
                                           userName: "o달빔o",
                                           profileImage: URL(string: "https://images-ext-1.discordapp.net/external/wGnZ_ZYU8R3dpD6TuirMAYy4MMxXGK5FZ0bXDkViwHc/https/lh3.googleusercontent.com/a-/AFdZucovSc1tTn1tLVqxz2O8O9s3IZwxAZB3Xr6dIc34%3Ds96-c")!),
                                           content: ["Review":review],
                                lastModifiedAt: CustomDateFormatter.shared.dateToString(from: Date()))
        
        self.reviewList.value.insert(mockReview, at: 0)
        completion(nil)
      case .failure(let error):
        completion(error)
      }
    }
  }
}
