//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/12.
//

import Foundation
import UIKit

class KeyboardView: UIView {
    
    // MARK: - UIProperties
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = "ㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaa"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var keyboardContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var keyboardVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var keyboardFirstLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var keyboardSecondLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var keyboardThirdLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var shiftKeyButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var deleteKeyButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var keyboardFourthLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
        
        keyboardContentsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(keyboardContentsView)
        
        keyboardVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        keyboardContentsView.addSubview(keyboardVerticalStackView)
        
        [
         keyboardFirstLineStackView,
         keyboardSecondLineStackView,
         keyboardThirdLineStackView,
         keyboardFourthLineStackView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            keyboardVerticalStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        setupConstraintsOfTextLabel()
        setupConstraintsOfKeyboardContentsView()
        setupConstraintsOfKeyboardVerticalStackView()
    }
    
    func setupConstraintsOfTextLabel() {
        let textLabelHeightAutoLayout = textLabel.heightAnchor.constraint(equalToConstant: 30)
        textLabelHeightAutoLayout.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: keyboardContentsView.safeAreaLayoutGuide.topAnchor, constant: -16),
            textLabelHeightAutoLayout
        ])
    }
    
    func setupConstraintsOfKeyboardContentsView() {
        NSLayoutConstraint.activate([
            keyboardContentsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            keyboardContentsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            keyboardContentsView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            keyboardContentsView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3)
        ])
    }
    
    func setupConstraintsOfKeyboardVerticalStackView() {
        NSLayoutConstraint.activate([
            keyboardVerticalStackView.leadingAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.leadingAnchor),
            keyboardVerticalStackView.trailingAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.trailingAnchor),
            keyboardVerticalStackView.bottomAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.bottomAnchor),
            keyboardVerticalStackView.topAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
}


// 전처리
#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
        return KeyboardViewController()
    }
}

struct ViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        ViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 11")
    }
}
#endif

