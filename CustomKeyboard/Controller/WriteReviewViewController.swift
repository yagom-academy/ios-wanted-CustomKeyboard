//
//  WriteReviewViewController.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/12.
//

import UIKit

protocol WriteReviewViewControllerDelegate: AnyObject {
    func sendReviewMessage(review: String)
}

final class WriteReviewViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: WriteReviewViewControllerDelegate?
    private let keyboardIOManager = KeyboardIOManager()
    
    // MARK: - ViewProperties
    private lazy var customKeyboard: CustomKeyboardView = {
        guard let customKeyboard = Bundle.main.loadNibNamed("CustomKeyboardView", owner: nil)?.first as? CustomKeyboardView else { return CustomKeyboardView() }
        customKeyboard.delegate = keyboardIOManager
        
        return customKeyboard
    }()
    
    private lazy var writeReviewTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.font = .systemFont(ofSize: 20)
        textView.inputView = customKeyboard
        textView.becomeFirstResponder()
        
        return textView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingKeyboardManager()
        view.backgroundColor = .systemBackground
        configureSubViews()
        setConstraintsOfWriteReviewTextView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.sendReviewMessage(review: writeReviewTextView.text)
    }
    
    private func bindingKeyboardManager() {
        keyboardIOManager.updateTextView = { [weak self] in
            guard let self = self else { return }
            while !(self.writeReviewTextView.text.isEmpty) {
                self.writeReviewTextView.deleteBackward()
            }
            self.writeReviewTextView.insertText($0)
        }
        
        keyboardIOManager.dismiss = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - UI
extension WriteReviewViewController {
    private func configureSubViews() {
        writeReviewTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(writeReviewTextView)
    }
    
    private func setConstraintsOfWriteReviewTextView() {
        NSLayoutConstraint.activate([
            writeReviewTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            writeReviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            writeReviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            writeReviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
