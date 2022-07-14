//
//  HomeViewModel.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/12.
//

import Foundation

class HomeViewModel{
    private let networkService = NetworkService()
    var reviewList: Observable<[ReviewModel]> = Observable([])
    
    func reloadReviewList(){
        networkService.request(method: .get) { list in
            self.reviewList.value = list
        }
    }
}
