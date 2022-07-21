//
//  KeyboardViewController.swift
//  CustomKeyboardExtension
//
//  Created by 이경민 on 2022/07/20.
//

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
    var preValuesCount: Int = 0
    lazy var proxy = self.textDocumentProxy
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
//        let heightValue = (KeyboardButton.height * 4) + (8 * 3) + 13
//
//        self.view.heightAnchor.constraint(equalToConstant: heightValue).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.sizeToFit()

        self.keyboardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.nextKeyboardButton = UIButton(type: .system)

        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        
        self.inputBinding(proxy: proxy)
        self.deleteBinding(proxy: proxy)
        
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
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    func deleteBinding(proxy: UITextDocumentProxy) {
        keyboardView.viewModel.isDelete.bind { isDelete in
            if isDelete {
                
                if self.viewModel.result.value.isEmpty {
                    proxy.deleteBackward()
                    self.preValuesCount = 0
                    self.viewModel.isDelete.value = false
                    
                    return
                }
                
                if !self.viewModel.isRemovePhoneme {
                    proxy.deleteBackward()
                    self.preValuesCount = 0
                    self.viewModel.isDelete.value = false
                    return
                }
                
                
                if let lastValue = self.viewModel.result.value.last {
                    
                    let insertCount = lastValue.unicodeScalars.count
                    
                    if insertCount <= self.preValuesCount {

                        
                        proxy.deleteBackward()
                        if lastValue != " " {
                            proxy.insertText(String(lastValue))
                        }
                    } else {
                        proxy.deleteBackward()
                    }
                    
                    self.preValuesCount = insertCount
                    self.viewModel.isDelete.value = false
                }
            }
        }
        
        // 안녕하세요 -> 안녕하세ㅇ  2:1
        // 안녕하세ㅇ -> 안녕하세   1:2
        // 안녕하세  -> 안녕하서   2:2
        // 안녕하ㅅ -> 안녕하.    1:2
        
        // 안녕 -> 안녀.    3:2
        // 안녀 -> 안ㄴ.     2:1
        // 안ㄴ -> 안.      1:3
        // 안 -> 아.       3:2
        // 아 -> ㅇ        2:1
        // ㅇ -> ""       1:0
        
        // 안 녕 -> 안 녀    3:2
        // 안 녀 -> 안 ㄴ.   2:1
        // 안 ㄴ -> 안" ".   1:0
    }
    
    func inputBinding(proxy: UITextDocumentProxy) {
        viewModel.resultCompats.bind { charValue in
            guard let char = charValue else {
                return
            }
            
            let result = String(char)
            let count = result.unicodeScalars.count
            
            if result == " " {
                proxy.insertText(result)
                self.preValuesCount = 0
                return
            }
            
            // ㅇ u{}
            if self.preValuesCount == 0 {
                proxy.insertText(result)
                self.preValuesCount = count
                return
            }
            
            // 아 - 1:2 ㅇ ㅏ u{} u{}
            // 안 - 2:3
            
            if self.preValuesCount < count {
                proxy.deleteBackward()
                proxy.insertText(result)
            }
            
            // 3(앉) : 2(자)
            if self.preValuesCount > count {
                let indexs = self.viewModel.result.value.index(self.viewModel.result.value.endIndex, offsetBy: -2) //뒤에서 2개
                let prevValue = String(self.viewModel.result.value[indexs...]) // 안자
                
                proxy.deleteBackward()
                
                proxy.insertText(prevValue)
            }
            
            // 앉 3 : 3
            // 안자
            if self.preValuesCount == count {
                proxy.deleteBackward()
                proxy.insertText(result)
            }
            
            self.preValuesCount = count
        }
    }

}
