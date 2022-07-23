//
//  Date+.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import Foundation

extension Date {
    var intervalCurrentTime: String {
        let dateComponents = Calendar(identifier: .gregorian).dateComponents(
            [.day, .hour, .minute],
            from: self,
            to: Date()
        )
        
        guard let day = dateComponents.day,
              let hour = dateComponents.hour,
              let minute = dateComponents.minute else {
            return toString(format: "y년 MM월 dd일")
        }
        
        if day >= 1 {
            return toString(format: "y년 MM월 dd일")
        } else if hour >= 1 {
            return "\(hour)시간 전"
        } else {
            return "\(minute)분 전"
        }
    }
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
