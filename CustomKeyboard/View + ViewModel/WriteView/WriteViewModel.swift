//
//  WriteViewModel.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/16.
//

import UIKit

class WriteViewModel {
    let keyboardViewModel: KeyboardViewModel
    var resultText: Observable<String>
    
    var sendedText: Observable<String> = Observable("")
    
    init(keyboardViewModel: KeyboardViewModel) {
        self.keyboardViewModel = keyboardViewModel
        
        resultText = keyboardViewModel.result
    }
    
    lazy var keyBoardView: KeyboardView = {
        let keyboard = KeyboardView(viewModel: keyboardViewModel)
        keyboard.frame = CGRect(x: 0, y: 0, width: 0, height: 250)
        keyboard.backgroundColor = .gray
        return keyboard
    }()
    
    
}
