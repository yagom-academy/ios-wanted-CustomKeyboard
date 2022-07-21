//
//  KeyboardViewController.swift
//  CustomKeyboardExtension
//
//  Created by 이경민 on 2022/07/20.
//
// 1번 지워야 하는 경우 - false

/// 최후의 보루
//keyboardView.viewModel.result.bind { value in
//    if let documentCount = proxy.documentContextBeforeInput?.count {
//        for i in 0..<documentCount {
//            proxy.deleteBackward()
//        }
//    }
//    proxy.insertText(value)
//}


// 2번 지워야 하는 경우 - true
    // 1. 이중 종성이 있을때, 모음이 들어 온 경우
    // 2. 단종성이 있을 때, 모음이 들어 온 경우 - compat - next // 안녕핫 -> 안녕하세

// 지우면 안되는 경우 - nil
    // 1. 이중 종성이 있을 경우, 초성이 들어온 경우 - compat - next
    // 2. 단종성이 있을 경우, 이중 종성이 안되는 초성이 들어온 경우
    // 5. 단중성이 있을 때, 이중 중성이 안되는 경우
    // 6. 이중 중성이 있을때, 중성이 들어온 경우
    // 7. 초성이 있을때, 초성이 들어온 경우 - compat - next

import UIKit

//enum DeleteCase {
//    case once // 한번 지우는 경우 (기본값)
//    case twice // 두번 지우는 경우
//    case zero // 지우면 안되는 경우
//}

// ㅁ + ㅜ -> 2개 지우고 => 글자 1개 넣고
// 무 + 궁 -> 2개 지우고 => 글자가 1개라면  2개 넣고
// 무궁 + 화 -> 2개 지우고 => 글자가 1 3개 넣고
// 무궁화 + 삼 -> 2개 지우고 3개 넣고
// 무궁화삼 + 천 -> 2개 지우고 3개 넣고


// ㅁ ㅜ 무궁
class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    let viewModel = KeyboardViewModel()
    lazy var keyboardView = KeyboardView(viewModel: viewModel)
    var isDoubleDelete: Bool = false
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        self.view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        self.keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.keyboardView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        let proxy = self.textDocumentProxy
//        
//        keyboardView.viewModel.result.bind { value in
//            if !value.isEmpty {
//                proxy.insertText(String(UnicodeScalar(Chosung.ㄱ.rawValue)!))
//                proxy.insertText(String(UnicodeScalar(Jungsung.ㅏ.rawValue)!))
//                proxy.insertText(String(UnicodeScalar(Jungsung.ㅣ.rawValue)!))
//            }
//        }
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
//        print(textInput)
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
