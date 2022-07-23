//
//  HomeViewModel.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/12.
//

import Foundation

class HomeViewModel {

    private let networkService: Api
    private var reviewListModel: ReviewListModel?
    
    init(networkService: Api) {
        self.networkService = networkService
    }
}

extension HomeViewModel: HomeViewModelable {
    
    func reloadReviewList(completion: @escaping (Result<Void, Error>)->()) {
        networkService.request(httpMethod: .get, condent: "") { result in
            switch result {
            case .success(let list):
                self.reviewListModel = list as? ReviewListModel
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func countOfReviewListModel() -> Int {
        return self.reviewListModel?.data.count ?? 0
    }
    
    func getReviewModel(index: Int) -> Review? {
        return reviewListModel?.data[index]
    }
}
