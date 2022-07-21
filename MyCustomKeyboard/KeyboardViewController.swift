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
    private let keyboardManager = KeyboardManager()
    private let keyboardView = KeyboardView()
    private let viewModel = KeyboardViewModel()
    lazy var firstLineButtons = keyboardView.keyFirstLine.passButtons()
    private var state = 0
    
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//
//        // Add custom view sizing constraints here
//    }
    
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
                
        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
//    override func viewWillLayoutSubviews() {
//        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
//        super.viewWillLayoutSubviews()
//    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
        setProxy()
    }

//    override func textDidChange(_ textInput: UITextInput?) {
//        // The app has just changed the document's contents, the document context has been updated.
//
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
//    }
    
    func setProxy() {
        while self.textDocumentProxy.hasText {
            self.textDocumentProxy.deleteBackward()
        }
        self.textDocumentProxy.insertText(textView.text)
    }
}

extension KeyboardViewController: ButtonDelegate {
    func eraseButtonClickEvent(sender: KeyButton) {
        keyboardView.keyThirdLine.shiftButton.isSelected = false
        viewModel.resetShift(firstLineButtons)
        viewModel.eraseButton(textView)
    }
    
    func buttonClickEvent(sender: KeyButton) {
        viewModel.buttonClick(textView, keyboardView, sender)
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
