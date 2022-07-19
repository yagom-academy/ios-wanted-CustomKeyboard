//
//  ReviewWriteView.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import UIKit

class ReviewWriteViewController: UIViewController {
    
    // MARK: - Properties
    private var windowHeight: CGFloat {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.windowHeight!
    }
    private let textView = UITextView()
    private let customKeyboard = CustomKeyBoard()
    private var resultInputField: UITextView?
    
    init(inputField: UITextView) {
        super.init(nibName: nil, bundle: nil)
        self.resultInputField = inputField
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customKeyboard.frame.origin.y = windowHeight
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: {
            self.customKeyboard.frame.origin.y = self.windowHeight-CustomKeyBoard.Math.keyboardHeight
        }, completion: nil)
    }
}

//MARK: - 커스텀키보드 Delegate 메서드
extension ReviewWriteViewController: CustomKeyBoardDelegate {
    func tappedReturnButton() {
        
        guard let message = self.textView.text else { return }
        self.resultInputField?.text = message
        if (self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    func connectTextView() -> UITextView {
        
        return self.textView
    }
}

//MARK: - ConfigureUI
extension ReviewWriteViewController {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        self.title = " 리뷰 작성 "
        view.backgroundColor = .white
        textView.font = .systemFont(ofSize: 20)
        
        customKeyboard.delegate = self
    }
    
    private func configureLayout() {
        [textView, customKeyboard].forEach {
            view.addSubview($0)
        }
        
        customKeyboard.frame = CGRect(x: 0, y: windowHeight, width: CustomKeyBoard.Math.keyboardWidth, height: CustomKeyBoard.Math.keyboardHeight)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: customKeyboard.topAnchor).isActive = true
    }
}
