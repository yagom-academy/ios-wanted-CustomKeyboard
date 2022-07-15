//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

protocol PassReviewDelegate {
    func sendReviewData(review: Review)
}

class KeyboardViewController: UIViewController {
    var delegate: PassReviewDelegate?
    private var viewModel = KeyboardViewModel()
    
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
        addTarget()
        bind(viewModel)
        
        let precomposed: Character = "\u{D55C}"
        print(precomposed, "here")
        
        let unicode: String = String(UnicodeScalar(4352)!)
        print(unicode)
        
        let unicode2: String = "\u{1100}" // 0x1100 = 4352
        print(unicode2)                 // ㄱ
    }
}

extension KeyboardViewController {
    private func layout() {
        view.backgroundColor = .white
        
        [
            reviewTextField,
            keyboardView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            reviewTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextField.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            reviewTextField.bottomAnchor.constraint(equalTo: keyboardView.topAnchor),
            
            keyboardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            keyboardView.widthAnchor.constraint(equalTo: view.widthAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    private func addTarget() {
        keyboardView.keyFourthLine.returnButton.addTarget(self, action: #selector(returnButtonEvent), for: .touchUpInside)
    }
    
    private func bind(_ viewModel: KeyboardViewModel) {
        self.viewModel = viewModel
    }
    
    @objc private func returnButtonEvent() {
        if let content = reviewTextField.text {
            
            let review = viewModel.postReview(content: content) { result in
                switch result {
                case .success(let post):
                    print(post)
                case .failure(_):
                    print(Error.self)
                }
            }
            
            delegate?.sendReviewData(review: review)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
