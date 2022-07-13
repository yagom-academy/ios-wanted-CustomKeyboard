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
    
    private let stackView = KeyFirstLineStackView()
    
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(reviewTextField)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            reviewTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextField.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            reviewTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: reviewTextField.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}
