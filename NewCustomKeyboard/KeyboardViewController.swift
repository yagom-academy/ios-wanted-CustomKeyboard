//
//  KeyboardViewController.swift
//  NewCustomKeyboard
//
//  Created by dong eun shin on 2022/07/22.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    lazy var keyboardView = KeyboardView()
    var text: String = ""
    lazy var proxy = textDocumentProxy as UITextDocumentProxy
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(keyboardView)
        keyboardView.sizeToFit()
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        keyboardView.buttons.forEach { bttn in
            bttn.addTarget(self, action: #selector(tapKeyboard), for: .touchDown)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated
    }
    
    @objc
    func tapKeyboard(_ sender: UIButton){
        guard let char = sender.titleLabel?.text else {
          return
        }
        proxy.insertText(char)
    }

}
