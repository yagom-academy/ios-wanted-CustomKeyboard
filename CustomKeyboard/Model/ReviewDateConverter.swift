//
//  ReviewDateConverter.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/20.
//

import Foundation

class ReviewDateConverter {
    
    func convertReviewDate(rawData: String) -> String {
        if rawData.stringToDate ?? Date() > Date(timeIntervalSinceNow: -86400) {
            return rawData.stringToDate?.dateToRelativeTimeString ?? rawData
        } else {
            return rawData.stringToDate?.dateToOverTimeString ?? rawData
        }
    }
    
}
