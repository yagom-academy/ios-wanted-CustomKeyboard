//
//  Icon.swift
//  CustomKeyboard
//
//

import UIKit

enum Icon {
    case shift
    case shiftFill
    case personFill

    var image: UIImage {
        switch self {
        case .shift:
            return UIImage(systemName: "shift") ?? UIImage()
        case .shiftFill:
            return UIImage(systemName: "shift.fill") ?? UIImage()
        case .personFill:
            return UIImage(systemName: "person.crop.circle.fill") ?? UIImage()
        }
    }
}
