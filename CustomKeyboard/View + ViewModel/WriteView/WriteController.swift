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
//        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textContainer.maximumNumberOfLines = 0
        return textView
    }()
    
    lazy var keyBoardView: KeyboardView = {
        let keyboard = KeyboardView()
        keyboard.delegate = self
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

////MARK: - UITextViewDelegate
//extension WriteController: UITextViewDelegate {
//    func textViewDidEndEditing(_ textView: UITextView) {
//        delegate?.commentValue = textView.text
//    }
//}

//MARK: - KeyboardViewDelegate
extension WriteController: KeyboardViewDelegate {
    var reviewText: String {
        get {
            return commentEditView.text
        }
        set {
            commentEditView.text = newValue
        }
    }
    func keyboardView(_ keyboard: KeyboardView, didEndEditing: Bool, text: String) {
        delegate?.commentValue = text
        dismiss(animated: true)
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
