//
//  KeyboardViewController.swift
//  My Custom Keyboard
//
//  Created by 효우 on 2022/07/21.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    private let keyboardManager = HangulKeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let customKeyboardView = Bundle.main.loadNibNamed(
            "CustomKeyboard",
            owner: nil
            )?.first as?
            CustomKeyboardView else {
            return
            }
        customKeyboardView.delegate = self
        keyboardManager.delegate = self

        guard let inputView = inputView else { return }
        inputView.addSubview(customKeyboardView)
        customKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customKeyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            customKeyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            customKeyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            customKeyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
        ])
    }
}

extension KeyboardViewController: KeyboardInfoReceivable, HangulKeyboardDataReceivable {

    func customKeyboardView(pressedKeyboardButton: UIButton) {
        guard let textData = pressedKeyboardButton.titleLabel?.text else { return }
        keyboardManager.enterText(text: textData)
    }
    
    func hangulKeyboard(enterPressed: HangulKeyboardData) {
        self.dismissKeyboard()
    }
    
    func hangulKeyboard(updatedResult text: String) {
        while self.textDocumentProxy.hasText {
            self.textDocumentProxy.deleteBackward()
        }
        self.textDocumentProxy.insertText(text)
    }
}
