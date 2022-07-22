//
//  ReviewWriteView.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import UIKit

final class ReviewWriteViewController: UIViewController {
    
    // MARK: - Properties
    private let windowHeight: CGFloat = UIScreen.main.bounds.height
    private let textView = UITextView()
    private let customKeyboard = CustomKeyBoardStackView()
    private let resultInputField: UITextView
    
    init(inputField: UITextView) {
        resultInputField = inputField
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customKeyboard.frame.origin.y = windowHeight
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.customKeyboard.frame.origin.y = self.windowHeight-CustomKeyBoardStackView.Math.keyboardHeight
        }, completion: nil)
    }
}

//MARK: - 커스텀키보드 Delegate 메서드
extension ReviewWriteViewController: CustomKeyBoardStackViewDelegate {
    func tappedReturnButton() {
        
        guard let message = self.textView.text else { return }
        resultInputField.text = message
        if (navigationController != nil) {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    func connectTextView() -> UITextView {
        
        return textView
    }
}

//MARK: - ConfigureUI
extension ReviewWriteViewController {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        title = " 리뷰 작성 "
        view.backgroundColor = .white
        textView.font = .systemFont(ofSize: 20)
        
        customKeyboard.delegate = self
    }
    
    private func configureLayout() {
        [textView, customKeyboard].forEach {
            view.addSubview($0)
        }
        
        customKeyboard.frame = CGRect(x: 0, y: windowHeight, width: CustomKeyBoardStackView.Math.keyboardWidth, height: CustomKeyBoardStackView.Math.keyboardHeight)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: customKeyboard.topAnchor).isActive = true
    }
}
