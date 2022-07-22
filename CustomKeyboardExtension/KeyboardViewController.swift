//
//  KeyboardViewController.swift
//  CustomKeyboardExtension
//
//  Created by 이경민 on 2022/07/20.
//
import UIKit

class KeyboardViewController: UIInputViewController {
    // MARK: - Properties
    @IBOutlet var nextKeyboardButton: UIButton!
    let viewModel = KeyboardViewModel()
    lazy var keyboardView = KeyboardView(viewModel: viewModel)
    var isDoubleDelete: Bool = false
    var preValuesCount: Int = 0
    lazy var proxy = self.textDocumentProxy
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
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
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
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
        

    }
    
    func inputBinding(proxy: UITextDocumentProxy) {
        viewModel.resultCompats.bind { charValue in
            guard let char = charValue else {
                return
            }
            
            let result = String(char)
            let count = result.unicodeScalars.count
            
            // 띄어쓰기 할 경우
            if result == " " {
                proxy.insertText(result)
                self.preValuesCount = 0
                return
            }
            
            // 0("") : 1(ㅇ)
            if self.preValuesCount == 0 {
                proxy.insertText(result)
                self.preValuesCount = count
                return
            }
            
            // 1(아) : 2(ㅇ ㅏ)
            // 2(아) : 3(안)
            
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
            
            // 3(안) : 3 (앉)
            if self.preValuesCount == count {
                proxy.deleteBackward()
                proxy.insertText(result)
            }
            
            self.preValuesCount = count
        }
    }

}
