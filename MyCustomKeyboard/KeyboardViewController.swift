//
//  KeyboardViewController.swift
//  MyCustomKeyboard
//
//  Created by 백유정 on 2022/07/21.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    private let keyboardManager = KeyboardManager()
    
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//
//        // Add custom view sizing constraints here
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myCustomKeyboard = KeyboardView()
        
        guard let inputView = inputView else { return }
        inputView.addSubview(myCustomKeyboard)
        myCustomKeyboard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myCustomKeyboard.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            myCustomKeyboard.topAnchor.constraint(equalTo: inputView.topAnchor),
            myCustomKeyboard.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            myCustomKeyboard.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
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
//
//    override func textWillChange(_ textInput: UITextInput?) {
//        // The app is about to change the document's contents. Perform any preparation here.
//    }
//
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
}

extension KeyboardViewController {
    
}
