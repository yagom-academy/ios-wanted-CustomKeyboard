//
//  KeyboardViewController.swift
//  MyCustomKeyboard
//
//  Created by 백유정 on 2022/07/21.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    private let textView = UITextView()
    private let keyboardView = KeyboardView()
    private let viewModel = KeyboardViewModel()
    
    private lazy var firstLineButtons = keyboardView.keyFirstLine.passButtons()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let inputView = inputView else { return }
        inputView.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            keyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
        ])
    }
    
    func setProxy() {
        while self.textDocumentProxy.hasText {
            self.textDocumentProxy.deleteBackward()
        }
        self.textDocumentProxy.insertText(textView.text)
    }
}

extension KeyboardViewController: ButtonDelegate {
    func eraseButtonClickEvent(sender: KeyButton) {
        viewModel.eraseButton(textView, keyboardView)
    }
    
    func buttonClickEvent(sender: KeyButton) {
        viewModel.buttonClick(textView, keyboardView, sender)
        print(textView.text)
    }
}

extension KeyboardViewController: ShiftDelegate {
    func shiftClickEvent(isShift: Bool) {
        if isShift {
            viewModel.changeShift(firstLineButtons)
        } else {
            viewModel.resetShift(firstLineButtons)
        }
    }
}
