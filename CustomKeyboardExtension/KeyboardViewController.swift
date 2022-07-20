//
//  KeyboardViewController.swift
//  CustomKeyboardExtension
//
//  Created by J_Min on 2022/07/19.
//

import UIKit

final class KeyboardViewController: UIInputViewController {
    
    // MARK: - Properties
    private let keyboardIOManager = KeyboardIOManager()
    
    // MARK: - ViewProperties
    private lazy var customKeyboard: CustomKeyboardView = {
        guard let customKeyboard = Bundle.main.loadNibNamed("CustomKeyboardView", owner: nil)?.first as? CustomKeyboardView else {
            return CustomKeyboardView()
        }
        customKeyboard.delegate = keyboardIOManager
        
        return customKeyboard
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraintsOfCustomKeyboard()
        bindingKeyboardManager()
    }
    
    // MARK: - Method
    private func bindingKeyboardManager() {
        keyboardIOManager.updateTextView = { [weak self] in
            guard let self = self else { return }
            
            while self.textDocumentProxy.hasText {
                self.textDocumentProxy.deleteBackward()
            }
            self.textDocumentProxy.insertText($0)
        }
        
        keyboardIOManager.dismiss = { [weak self] in
            self?.dismissKeyboard()
        }
    }
}

// MARK: - UI
extension KeyboardViewController {
    private func setConstraintsOfCustomKeyboard() {
        guard let inputView = inputView else { return }
        inputView.addSubview(customKeyboard)
        customKeyboard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customKeyboard.topAnchor.constraint(equalTo: inputView.topAnchor, constant: 10),
            customKeyboard.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
            customKeyboard.trailingAnchor.constraint(equalTo: inputView.trailingAnchor),
            customKeyboard.bottomAnchor.constraint(equalTo: inputView.bottomAnchor, constant: -10)
        ])
    }
}
