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
    let viewModel: WriteViewModel
    
    lazy var commentEditView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textContainer.maximumNumberOfLines = 0
        return textView
    }()
    
    init(viewModel: WriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.commentEditView.inputView = viewModel.keyBoardView
        
        commentEditView.text = delegate?.commentValue
        configUI()
        
        bindResult()
    }
    
    func bindResult() {
        viewModel.resultText.bind { [weak self] result in
            self?.commentEditView.text = result
            self?.viewModel.sendedText.value = result
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
