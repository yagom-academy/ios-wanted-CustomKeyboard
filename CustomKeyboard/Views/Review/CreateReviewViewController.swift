//
//  CreateReviewViewController.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import UIKit

class CreateReviewViewController: UIViewController {

    private let reviewTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setKeyboardInputView()
    }
    
    private func setLayout() {
        view.addSubview(reviewTextView)
        
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            reviewTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            reviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setKeyboardInputView() {
         
    }
    
    private func dissmiss() {
        self.dismiss(animated: true)
    }

}
