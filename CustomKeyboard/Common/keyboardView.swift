//
//  keyboardView.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/16.
//

import UIKit

class KeyboardView: UIView {
    
    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    let stackView3 = UIStackView()
    let stackView4 = UIStackView()
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let button5 = UIButton()
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    let button9 = UIButton()
    let button10 = UIButton()
    let button11 = UIButton()
    let button12 = UIButton()
    let button13 = UIButton()
    let button14 = UIButton()
    let button15 = UIButton()
    let button16 = UIButton()
    let button17 = UIButton()
    let button18 = UIButton()
    let button19 = UIButton()
    let button20 = UIButton()
    let button21 = UIButton()
    let button22 = UIButton()
    let button23 = UIButton()
    let button24 = UIButton()
    let button25 = UIButton()
    let button26 = UIButton()
    let button27 = UIButton()
    let button28 = UIButton()
    let button29 = UIButton()
    let button30 = UIButton()
    let button31 = UIButton()
    
    lazy var buttons = [button1, button2,button3, button4, button5,
                        button6, button7, button8, button9, button10,
                        button11, button12, button13, button14, button15,
                        button16, button17, button18, button19, button20,
                        button21,button22,button23,button24,button25,
                        button26, button27, button28, button29, button30,
                        button31]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupView()
        setupConstraints()
        setButtonTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("Custom Button Error")
    }

    func setupView() {
        setupStackView()
    }

    private func setupStackView() {
        [stackView1, stackView2, stackView3, stackView4]
            .forEach {
                $0.spacing = 3
                $0.distribution = .fillEqually
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview($0)
            }
        [button1, button2, button3, button4, button5,button6,button7, button8, button9, button10,
         button11, button12, button13, button14, button15, button16, button17, button18, button19,
         button20, button21, button22, button23, button24, button25, button26, button27,
         button28, button29, button30, button31]
            .enumerated()
            .forEach { (index,buttn) in
                buttn.translatesAutoresizingMaskIntoConstraints = false
                buttn.backgroundColor = .white
                buttn.setTitleColor(.darkGray, for: .normal)
                buttn.addTarget(self, action: #selector(tapButtun(sender:)), for: .touchDown)
                if index < 10{
                    stackView1.addArrangedSubview(buttn)
                }else if index >= 10 && index < 19 {
                    stackView2.addArrangedSubview(buttn)
                }else if index >= 19 && index < 27 {
                    stackView3.addArrangedSubview(buttn)
                }else {
                    stackView4.addArrangedSubview(buttn)
                }
            }
    }

    func setupConstraints() {
      NSLayoutConstraint.activate([
        stackView1.topAnchor.constraint(equalTo: self.topAnchor),
        stackView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        stackView1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        stackView1.heightAnchor.constraint(equalToConstant: 55),
        
        stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor,constant: 3),
        stackView2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        stackView2.heightAnchor.constraint(equalToConstant: 55),
        
        stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor,constant: 3),
        stackView3.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        stackView3.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        stackView3.heightAnchor.constraint(equalToConstant: 55),
        
        stackView4.topAnchor.constraint(equalTo: stackView3.bottomAnchor,constant: 3),
        stackView4.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        stackView4.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        stackView4.heightAnchor.constraint(equalToConstant: 55),
      ])
    }
    private func setButtonTitle(){
        button1.setTitle("ㅂ", for: .normal)
        button2.setTitle("ㅈ", for: .normal)
        button3.setTitle("ㄷ", for: .normal)
        button4.setTitle("ㄱ", for: .normal)
        button5.setTitle("ㅅ", for: .normal)
        button6.setTitle("ㅛ", for: .normal)
        button7.setTitle("ㅕ", for: .normal)
        button8.setTitle("ㅑ", for: .normal)
        button9.setTitle("ㅐ", for: .normal)
        button10.setTitle("ㅔ", for: .normal)
        button11.setTitle("ㅁ", for: .normal)
        button12.setTitle("ㄴ", for: .normal)
        button13.setTitle("ㅇ", for: .normal)
        button14.setTitle("ㄹ", for: .normal)
        button15.setTitle("ㅎ", for: .normal)
        button16.setTitle("ㅗ", for: .normal)
        button17.setTitle("ㅓ", for: .normal)
        button18.setTitle("ㅏ", for: .normal)
        button19.setTitle("ㅣ", for: .normal)
        button20.setTitle("⬆", for: .normal)
        button21.setTitle("ㅋ", for: .normal)
        button22.setTitle("ㅊ", for: .normal)
        button23.setTitle("ㅍ", for: .normal)
        button24.setTitle("ㅠ", for: .normal)
        button25.setTitle("ㅜ", for: .normal)
        button26.setTitle("ㅡ", for: .normal)
        button27.setTitle("X", for: .normal)
        button28.setTitle("123", for: .normal)
        button29.setTitle("😊", for: .normal)
        button30.setTitle("SPACE", for: .normal)
        button31.setTitle("Return", for: .normal)
    }
    @objc
    func tapButtun(sender: UIButton){
        print(sender)
    }
}
