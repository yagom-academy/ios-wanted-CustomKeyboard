//
//  CustomKeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/21.
//

import Foundation

class CustomKeyboardViewModel {
    
    var text = Observable<String>("각")
    
    var hangeulManger = HangeulManger(HangeulConverter())

    func addChar(_ InputCode : Int ){
        
        guard let inputChar = UnicodeScalar(InputCode)?.description else {
            print("Fail Paring To Int")
            text.value = ""
            return
        }
        guard let lastChar = text.value.last, let lastCharUnicode = UnicodeScalar(String(lastChar))?.value else {
            print("Fail Paring To String")
            text.value = inputChar
            return
        }
        self.text.value = hangeulManger.addChar(Int(lastCharUnicode), InputCode)
    }
}
