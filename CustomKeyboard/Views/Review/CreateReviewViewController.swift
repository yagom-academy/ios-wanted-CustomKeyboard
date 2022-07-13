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
        guard let customKeyboardView = Bundle.main.loadNibNamed("CustomKeyboard", owner: nil)?.first as? CustomKeyboardView else { return }
        customKeyboardView.delegate = self
        reviewTextView.inputView = customKeyboardView
        
    }
    
    private func dissmiss() {
        self.dismiss(animated: true)
    }

}

extension CreateReviewViewController: KeyboardInfoReceivable {
    func customKeyboardView(pressedKeyboardButton: UIButton) {
        let hungul = pressedKeyboardButton.titleLabel!.text!
        
        
        
        
        let keyboadMaker = KeyboardMaker()

        
        keyboadMaker.putHangul(input: hungul)
        
        
    }
    func customKeyboardView(pressedDeleteButton: UIButton) {
        
    }
}

extension CreateReviewViewController {
    
    
    
}
