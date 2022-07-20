//
//  CreateReviewViewController.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import UIKit

protocol ReviewTextReceivable: AnyObject {
    func hangulKeyboardText(text: String)
}

class CreateReviewViewController: UIViewController {

    weak var delegate: ReviewTextReceivable?
    
    private let keyboardManager = HangulKeyboardManager()
    
    private let reviewTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 30)
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
        
        API.shared.post(message: reviewTextView.text) { [self] error in
            if let error = error {
                reviewDataPostErrorHandler(error: error)
            } else {
                DispatchQueue.main.async { [self] in
                    self.navigationController?.popViewController(animated: true)
                    delegate?.hangulKeyboardText(text: reviewTextView.text)
                }
            }
        }
    }
    
    func hangulKeyboard(updatedResult text: String) {
        reviewTextView.text = text
    }
    
    func reviewDataPostErrorHandler(error: Error) {
        let alert = UIAlertController(title: "리뷰 포스트 실패!", message: "오류코드: \(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
