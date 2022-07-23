//
//  ReviewDTO.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/11.
//

import Foundation

struct ReviewResponse: Codable {
  let data: [ReviewDTO]
}

// MARK: - Review
struct ReviewDTO: Codable {
  let id: String
  let user: User
  let content, createdAt, updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case user, content, createdAt, updatedAt
  }
}

extension ReviewDTO {
  func toDomain() -> Review {
    let content = parseReview(contents: content)
    let date = computeModifiedDate(updatedDate: updatedAt)
    return Review(id: id, user: user, content: content, lastModifiedAt: date)
  }
  
  private func parseReview(contents: String) -> [String:String]{
    let container = contents.components(separatedBy: "\n")
    var tempDict = [String:String]()
    container.forEach({
      let splits = $0.components(separatedBy: ":")
      tempDict.updateValue(splits.last ?? "", forKey: splits.first ?? "")
    })
    if let rate = tempDict["Rating"], let review = tempDict["Review"] {
      return ["Rating": rate, "Review":review]
    }else{
      let content = tempDict.first
      return ["Review":content?.value ?? ""]
    }
  }
  
  private func computeModifiedDate(updatedDate: String) -> String {
    let day = 86400
    let hour = day / 24
    let minute = hour / 60
    let dateDifferenceInSecond = Int(Date().timeIntervalSince(updatedDate.toDate())) //Date 차이
    
    switch dateDifferenceInSecond {
    case let timeDiff where timeDiff < hour:
      return "\(timeDiff/minute) 분"
    case let timeDiff where timeDiff < day && timeDiff > hour:
      return "\(timeDiff/hour) 시간 전"
    case let timeDiff where timeDiff > day:
      return "\(CustomDateFormatter.shared.dateToString(from: updatedDate.toDate()))"
    default:
      break
    }
    return ""
  }
}


// MARK: - User
struct User: Codable {
  let id: String
  let userName: String
  let profileImage: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case userName, profileImage
  }
}
