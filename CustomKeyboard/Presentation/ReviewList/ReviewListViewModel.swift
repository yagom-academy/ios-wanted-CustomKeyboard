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
        
        enum IntervalRange: Int {
            case in60MinutesRange
            case in24HoursRange
            
            var range: PartialRangeUpTo<Int> {
                switch self {
                case .in60MinutesRange : return ..<3600
                case .in24HoursRange : return ..<86400
                }
            }
        }
        
        let createdDateString: String
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let createdDate = dateFormatter.date(from: createdAtTime) else { return "" }
        
        //현재날짜와 생성된 날짜의 시간차의 초단위
        let interval = Int(now.timeIntervalSince(createdDate))
        let minutes = interval/60
        let hours = interval/3600
        
        switch interval {
            
        //1시간 이내
        case IntervalRange.in60MinutesRange.range :
            createdDateString = "\(minutes)분 전"
        //하루 이내
        case IntervalRange.in24HoursRange.range :
            createdDateString = "\(hours)시간 전"
        //하루 이상
        default:
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            createdDateString = dateFormatter.string(from: createdDate)
        }
        return createdDateString
    }
}

