//
//  basicKeyOneLine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import UIKit

class BasicKeyLine: UIStackView {
    var buttons: [UIButton]?
    private var textField: UITextField?
    
    init(keys:[String]) {
        super.init(frame: CGRect.zero)
        
        makeKeyButton(keys)
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - attibute()
extension BasicKeyLine {
    private func attribute() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
    }
}

//MARK: - layout
extension BasicKeyLine {
    private func layout() {
        guard let buttons = buttons else {
            return
        }
        
        let buttonWidth = CustomKeyBoard.Math.buttonWidth
        
        buttons.forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        }
    }
}

//MARK: - 키버튼을 만드는 메서드
extension BasicKeyLine {
    private func makeKeyButton(_ keys: [String]) {
        self.buttons = keys.map { key in
            let btn = UIButton(type: .system)
            btn.setTitle("\(key)", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .gray
            btn.layer.cornerRadius = 10
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
            btn.tag = Int(UnicodeScalar(key)!.value)
            btn.sizeToFit()
            btn.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
            return btn
        }
    }
    
    @objc func tappedButton(_ sender: UIButton) {
        print(sender.tag)
        print(String(UnicodeScalar(sender.tag)!))
//        guard let textField = textField else { return }
//        textField.text = (textField.text ?? "") + key
    }
}
