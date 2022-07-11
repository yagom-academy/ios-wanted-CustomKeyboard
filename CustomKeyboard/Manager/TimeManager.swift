//
//  TimeManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/11.
//

import Foundation

class TimeManager {
    static let shared = TimeManager()
    private init() { }
    
    func getTimeInterval(_ timeString: String) -> String {
        
        let timeIntervalString: String
        let dateFormatter = DateFormatter()
        let timeDate = dateFormatter.toDate(from: timeString, "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        let timeInterval = Date().timeIntervalSince(timeDate)
        
        switch timeInterval {
        case ..<3600:
            timeIntervalString = "\(Int(timeInterval/60))분"
        case ..<(3600*24):
            timeIntervalString = "\(Int(timeInterval/3600))시간"
        default:
            timeIntervalString = dateFormatter.toString(from: timeDate, "yyyy년 MM월 dd일")
        }
        return timeIntervalString
    }
}
