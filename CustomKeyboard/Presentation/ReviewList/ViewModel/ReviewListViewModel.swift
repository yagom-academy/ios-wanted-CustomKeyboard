//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by 조성빈 on 2022/07/19.
//

import Combine
import UIKit

class ReviewListViewModel: ObservableObject {
    
    @Published var reviewList : ReviewList?
    let reviewDataManager = ReviewDataManager()
    
    init() {}
}

extension ReviewListViewModel {
    func getDataFromServer() {
        reviewDataManager.getData("https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") {[weak self] result in
            self?.reviewList = result
        }
    }
    
    func postDataToServer(_ content : String) {
        reviewDataManager.postData("https://api.plkey.app/tmp/theme/PLKEY0-L-81/review", content) {[weak self] content in
            guard let content = content else {
                return
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'hh:mm"
            let reviewTime = formatter.string(from: Date())
            self?.reviewList?.data.insert(ReviewData(user: User(userName: "비공개", profileImage: "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"), content: content, createdAt: reviewTime), at: 0)
        }
    }
}

extension ReviewListViewModel {
    func makeTimeLine(_ time : String) -> String {
        // 현재 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        let current = formatter.string(from: Date()).split(separator: " ")
        let currentDate = current[0]
        let currentTime = current[1]
        let currentHour = isFirstZero(String(currentTime.split(separator: ":")[0]))
        let currentMinute = isFirstZero(String(currentTime.split(separator: ":")[1]))
        
        // 주어진 시간
        let splitReviewDate = time.split(separator: "T")
        let reviewDate = splitReviewDate[0]
        let reviewTime = splitReviewDate[1]
        let splitReviewTime = reviewTime.split(separator: ":")
        let reviewHour = isFirstZero(String(splitReviewTime[0]))
        let reviewMinute = isFirstZero(String(splitReviewTime[1]))
        
        if currentDate != reviewDate {
            return String(reviewDate)
        } else {
            if currentHour == reviewHour {
                let minuteDifference = (Int(currentMinute) ?? 0) - (Int(reviewMinute) ?? 0)
                if minuteDifference != 0 {
                    return ("\(Int(currentMinute)! - Int(reviewMinute)!)분 전")
                } else {
                    return "방금 전"
                }
            } else {
                 return ("\(reviewHour)시간 전")
            }
        }
    }
    
    func isFirstZero(_ timeString : String) -> String {
        if timeString.first == "0" {
            return String(timeString.dropFirst())
        } else {
            return String(timeString)
        }
    }
    
    func makeStringToImage(_ imageString : String) -> UIImage? {
        guard let url = URL(string: imageString) else {return nil}
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("error")
            return nil
        }
    }
}
