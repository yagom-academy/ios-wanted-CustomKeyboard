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
    var returnButtonTapped: Observable<Bool>
    
    init(keyboardViewModel: KeyboardViewModel) {
        self.keyboardViewModel = keyboardViewModel
        
        resultText = keyboardViewModel.result
        returnButtonTapped = keyboardViewModel.returnButtonTapped
    }
    
    func clearAll() {
        self.resultText.value = ""
        self.sendedText.value = ""
    }
}
