//
//  basicKeyOneLine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import UIKit

class BasicKeyLine: UIStackView {
    
    // MARK: - Properties
    var buttons: [UIButton]?
    weak var delegate: BasicKeyLineDelegate?
    
    init(keys:[String]) {
        super.init(frame: CGRect.zero)
        
        makeKeyButton(keys)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ConfigureUI
extension BasicKeyLine {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    
    private func configureAttribute() {
        
        axis = .horizontal
        distribution = .equalSpacing
    }
    
    private func configureLayout() {
        
        guard let buttons = buttons else {
            return
        }
        
        let buttonWidth = CustomKeyBoardStackView.Math.buttonWidth
        
        buttons.forEach {
            addArrangedSubview($0)
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
            btn.layer.cornerRadius = 10
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
            btn.tag = Int(UnicodeScalar(key)!.value)
            btn.sizeToFit()
            btn.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
            btn.titleLabel?.font = .systemFont(ofSize: CustomKeyBoardStackView.Math.fontSize)
            btn.layer.shadowColor = UIColor.black.cgColor
            btn.layer.masksToBounds = false
            btn.layer.shadowOffset = CGSize(width: 2, height: 2)
            btn.layer.shadowRadius = 2
            btn.layer.shadowOpacity = 0.5
            return btn
        }
    }
    
    @objc func tappedButton(_ sender: UIButton) {
        delegate?.tappedBasicKeyButton(unicode: sender.tag)
    }
}
