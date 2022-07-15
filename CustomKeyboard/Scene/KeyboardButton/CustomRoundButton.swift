//
//  CustomRoundButton.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/14.
//

import UIKit

class CustomRoundButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        self.clipsToBounds = true
        self.tintColor = .white
        
    }
    
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
            UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
            
            let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
             
            self.setBackgroundImage(backgroundImage, for: state)
        }
}
