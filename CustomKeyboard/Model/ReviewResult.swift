//
//  ReviewResult.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

struct ReviewResult: Decodable {

    let user: User
    let content: String
    let createdAt: String
}

// MARK: - Upload time converting methods

extension ReviewResult {
    
    private func convertDateToFormat() -> String {
        let characterSet = CharacterSet(charactersIn: "+,.")
        var slicedCreatedTime = createdAt.components(separatedBy: characterSet)
        slicedCreatedTime.removeLast()
        let timeWithFormat = slicedCreatedTime.joined().map { char -> Character in
            if char.isLetter {
                return " "
            }
            return char
        }

        return String(timeWithFormat)
    }
    
    func toElapsedTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.timeZone = TimeZone(identifier: "UTC")
        
        guard let createdDate = format.date(from: convertDateToFormat()) else {
            return createdAt
        }
        let interval = createdDate.timeIntervalSinceNow
        
        if interval >= 0 {
            return createdAt
        }
        
        let absIntervalValue = Int(interval.magnitude)
        switch absIntervalValue {
        case TimeScale.hour.rawValue..<TimeScale.day.rawValue:
            return "\(absIntervalValue / TimeScale.hour.rawValue)시간 전"
        case TimeScale.minite.rawValue..<TimeScale.hour.rawValue:
            return "\(absIntervalValue / TimeScale.minite.rawValue)분 전"
        case 0..<TimeScale.minite.rawValue:
            return "\(absIntervalValue)초 전"
        default:
            return toYearMonthDay()
        }
    }
    
    private func toYearMonthDay() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.timeZone = TimeZone(identifier: "UTC")
        
        guard let createdDate = format.date(from: convertDateToFormat()) else {
            return createdAt
        }
        
        return createdDate.formatted(
            Date.FormatStyle()
                .year(.defaultDigits)
                .month(.twoDigits)
                .day(.twoDigits)
        )
    }
    
    private enum TimeScale: Int {
        case minite = 60 // scale by seconds
        case hour = 3600 // minite * 60
        case day = 86400 // hour * 24
    }
}
