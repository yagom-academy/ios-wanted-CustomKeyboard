//
//  CreateReviewViewController.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import UIKit

class CreateReviewViewController: UIViewController {

    private let keyboardManager = HangulKeyboardManager()
    
    private let reviewTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setKeyboardInputView()
        keyboardManager.delegate = self
    }
    
    private func setLayout() {
        
        view.addSubview(reviewTextView)
        
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            reviewTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            reviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setKeyboardInputView() {
        guard let customKeyboardView = Bundle.main.loadNibNamed("CustomKeyboard", owner: nil)?.first as? CustomKeyboardView else { return }
        customKeyboardView.delegate = self
        reviewTextView.inputView = customKeyboardView
    }
}

extension CreateReviewViewController: KeyboardInfoReceivable {
    
    func customKeyboardView(pressedKeyboardButton: UIButton) {
        let textData = pressedKeyboardButton.titleLabel!.text!
        keyboardManager.enterText(text: textData)
    }
    
}

extension CreateReviewViewController: HangulKeyboardDataReceivable {
    
    func hangulKeyboard(enterPressed: HangulKeyboardData) {
        self.dismiss(animated: true)
    }
    
    func hangulKeyboard(updatedResult text: String) {
        reviewTextView.text = text
    }
    
}
