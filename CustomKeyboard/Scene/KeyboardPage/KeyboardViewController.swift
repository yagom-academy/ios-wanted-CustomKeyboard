//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

protocol PassContentDelegate {
    func sendReviewData(content: String)
}

class KeyboardViewController: UIViewController {
    var delegate: PassContentDelegate?
    private var viewModel = ReviewTableViewHeaderViewModel()
    private let manager = KeyboardManager()
    private var state = 0
    
    private let reviewTextView: UITextView = {
        var textView = UITextView()
        textView.font = .systemFont(ofSize: 50, weight: .medium)
        
        return textView
    }()
    
    private let keyboardView = KeyboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        addTarget()
        bind(viewModel)
        keyboardView.keyFirstLine.delegate = self
        keyboardView.keySecondLine.delegate = self
        keyboardView.keyThirdLine.delegate = self
        keyboardView.keyFourthLine.delegate = self
    }
}

extension KeyboardViewController {
    private func layout() {
        view.backgroundColor = .white
        
        [
            reviewTextView,
            keyboardView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            reviewTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            reviewTextView.bottomAnchor.constraint(equalTo: keyboardView.topAnchor),
            
            keyboardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            keyboardView.widthAnchor.constraint(equalTo: view.widthAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    private func addTarget() {
        keyboardView.keyFourthLine.returnButton.addTarget(self, action: #selector(returnButtonEvent), for: .touchUpInside)
    }
    
    private func bind(_ viewModel: ReviewTableViewHeaderViewModel) {
        self.viewModel = viewModel
    }
    
    @objc private func returnButtonEvent() {
        if let content = reviewTextView.text {
            delegate?.sendReviewData(content: content)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension KeyboardViewController: ButtonDelegate {
    func buttonClickEvent(sender: KeyButton) {
        guard let text = reviewTextView.text?.last else {
            let managerString = manager.makeString(state, "", sender)
            reviewTextView.text! += managerString.0
            state = managerString.1
            return
        }
        
        let managerString = manager.makeString(state, String(text), sender)
        
        if managerString.1 != 0 {
            reviewTextView.text.removeLast()
        }
        
        reviewTextView.text! += managerString.0
        state = managerString.1
    }
}
