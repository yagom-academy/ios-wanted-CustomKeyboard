//
//  WriteController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

//MARK: - CommentEditDelegate
protocol CommentEditDelegate: AnyObject {
    var commentValue: String? { get set }
}

class WriteController: UIViewController {
    weak var delegate: CommentEditDelegate?
    lazy var commentEditView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    lazy var keyBoardView: KeyboardView = {
        let keyboard = KeyboardView()
        keyboard.frame = CGRect(x: 0, y: 0, width: 0, height: 250)
        keyboard.backgroundColor = .gray
        return keyboard
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.commentEditView.inputView = keyBoardView
        
        commentEditView.text = delegate?.commentValue
        configUI()
    }

}

//MARK: - UITextViewDelegate
extension WriteController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        print("begin")
//        textView.inputView.re
    }
    func textViewDidChange(_ textView: UITextView) {
        delegate?.commentValue = textView.text
    }
}


//MARK: - View Configure
private extension WriteController {
    func configUI() {
        [commentEditView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            commentEditView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            commentEditView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            commentEditView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            commentEditView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
