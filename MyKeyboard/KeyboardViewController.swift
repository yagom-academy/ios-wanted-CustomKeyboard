//
//  KeyboardViewController.swift
//  MyKeyboard
//
//  Created by rae on 2022/07/18.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet weak var keyboardView: KeyboardView!
    private var myKeyboardView: UIView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInterface()
        
        keyboardView.setNextKeyboardVisible(needsInputModeSwitchKey)
        keyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        keyboardView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    private func loadInterface() {
        let keyboardNib = UINib(nibName: "MyKeyboard", bundle: nil)
        myKeyboardView = keyboardNib.instantiate(withOwner: self, options: nil).first as? UIView
        myKeyboardView.frame.size = view.frame.size
        view.addSubview(myKeyboardView)
    }
}

// MARK: - KeyboardViewDelegate

extension KeyboardViewController: KeyboardViewDelegate {
    func keyboardViewTouch(text: String) {
        if let beforeInputText = textDocumentProxy.documentContextBeforeInput {
            for _ in 0..<beforeInputText.count {
                textDocumentProxy.deleteBackward()
            }
        }
        textDocumentProxy.insertText(text)
    }
    
    func keyboardViewReturn() {}
}
