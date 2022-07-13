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
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        
        return textField
    }()
    
    private let keyboardView = KeyboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
}

//MARK: - attribute, layout 메서드
extension KeyboardViewController {
    
    private func layout() {
        view.backgroundColor = .white
        
        reviewTextField.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(reviewTextField)
        view.addSubview(keyboardView)
        
        NSLayoutConstraint.activate([
            
            reviewTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextField.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            reviewTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            keyboardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            keyboardView.widthAnchor.constraint(equalTo: view.widthAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
