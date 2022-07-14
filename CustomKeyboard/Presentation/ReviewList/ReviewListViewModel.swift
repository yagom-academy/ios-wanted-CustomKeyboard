//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/14.
//

import Foundation

class ReviewListViewModel {
    
    struct CellType {
        var profileURL: URL
        var userName: String
        var contents: String
        var createdAt: String
    }
    
    private var reviewDatas: [ReviewType] = []
    
    func fetchData(completion: @escaping () -> ()) {
        NetworkManager.shared.fetchReview { result in
            switch result {
            case .success(let result):
                self.reviewDatas = result.data
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postData(text: String, completion: @escaping (Result<NetworkManager.ResponseCode, CustomError>) -> ()) {
        NetworkManager.shared.postReview(message: "") { result in
            completion(result)
        }
    }
    
    func getCellTotalCount() -> Int {
        return reviewDatas.count
    }
    
    func getCellData(indexPath: IndexPath) -> CellType? {
        let row = indexPath.row
        
        guard let url = URL(string: self.reviewDatas[row].user.profileImage) else {
            return nil
        }
        
        let userName =  reviewDatas[row].user.userName
        let content = reviewDatas[row].content
        let createdAt = convertDateTime(createdAtTime: reviewDatas[row].createdAt)
        return CellType(profileURL: url, userName: userName, contents: content, createdAt: createdAt)
    }
    
    private func convertDateTime(createdAtTime: String) -> String {
        
        //TODO : 날짜 비교해서 보여주는 것 아직 안함
        // 댓글을 작성한 시간이 1시간 이내일 경우 분 단위로 표시,
        // 하루 이내일 경우 시간 단위로 표시
        // 하루 이상일 경우 년월일만 표시
        
        //Date형식 설정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //2021-10-29T02:14:10.135Z
        
        //String을 Date형식으로 바꿔주기
        let createdAtDateTime = dateFormatter.date(from: createdAtTime)
        
        //바꿔줄 원하는 날짜 형식 설정
        let myDataFormatter = DateFormatter()
        myDataFormatter.dateFormat = "yyyy년 MM월 dd일"
        myDataFormatter.locale = Locale(identifier: "ko_KR")
        
        //Date를 설정해둔 날짜 형식의 String으로 바꿔주기
        let convertCreatedAtStringTime = myDataFormatter.string(from: createdAtDateTime!)
        return convertCreatedAtStringTime
    }
    
    
}

