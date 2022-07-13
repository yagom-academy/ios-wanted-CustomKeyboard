//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

class KeyboardViewController: UIViewController {

    private let reviewTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "리뷰를 입력해주세요."
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.backgroundColor = .blue
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//MARK: - attribute, layout 메서드
extension KeyboardViewController {
    
    private func layout() {
        reviewTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(reviewTextField)
        
        NSLayoutConstraint.activate([
            
            reviewTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextField.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTextField.widthAnchor.constraint(equalTo: view.widthAnchor),
            reviewTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}
