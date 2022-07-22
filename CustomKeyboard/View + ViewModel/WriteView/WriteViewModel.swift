//
//  WriteViewModel.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/16.
//

import UIKit


class WriteViewModel {
    // MARK: - Properties
    // ViewModel
    let keyboardViewModel: KeyboardViewModel
    // Observable
    var resultText: Observable<String>
    var returnButtonTapped: Observable<Bool>
    
    // MARK: - Init
    init(keyboardViewModel: KeyboardViewModel) {
        self.keyboardViewModel = keyboardViewModel
        
        resultText = keyboardViewModel.result
        returnButtonTapped = keyboardViewModel.returnButtonTapped
    }
    
    func clearAll() {
        resultText.value = ""
    }
}
