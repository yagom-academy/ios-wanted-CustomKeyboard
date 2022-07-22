//
//  CustomKeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/21.
//

import Foundation

class CustomKeyboardViewModel {
  
  let firstLineCharList = ["ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ","ㅔ"]
  let secondLineCharList = ["ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ","ㅣ"]
  let thirdLineCharList = ["ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ"]
  
  var text = Observable<String>("")
  
  var hangeulManger = HangeulManger(HangeulConverter())
  
  
  func processText(operation: TextOperation) {
    switch operation {
    case .charPressed(let inputCode):
      addChar(inputCode)
    case .deletePressed:
      print("deletePressed")
    case .spacePressed:
      print("spacePressed")
    }
  }
  
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
