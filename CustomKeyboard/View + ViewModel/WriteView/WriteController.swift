//
//  WriteController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

final class WriteController: UIViewController {
    // MARK: - Properties
    private let viewModel: WriteViewModel
    
    // MARK: - UI Components
    lazy var commentEditView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    lazy var keyBoardView: KeyboardView = {
        let keyboard = KeyboardView(viewModel: viewModel.keyboardViewModel)
        keyboard.backgroundColor = .systemGray4
        return keyboard
    }()
    
    // MARK: - Init
    init(viewModel: WriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInputView()
        configUI()
        
        bindResult()
        bindReturnButtonTapped()
    }
}

// MARK: - Bind Methods
private extension WriteController {
    func bindResult() {
        viewModel.resultText.bind { [weak self] result in
            self?.commentEditView.text = result
        }
    }
    func bindReturnButtonTapped() {
        viewModel.returnButtonTapped.bind {
            if $0 {
                self.dismiss(animated: true)
                self.viewModel.returnButtonTapped.value = false
            }
        }
    }
}
// MARK: - @objc Methods
private extension WriteController {
    @objc func didTapDismissButton() {
        dismiss(animated: true)
    }
    @objc func didTapClearDismissButton() {
        viewModel.keyboardViewModel.clearAll()
        dismiss(animated: true)
    }
}

// MARK: - View Configure
private extension WriteController {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTapClearDismissButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(didTapDismissButton)
        )
        navigationItem.title = "리뷰 작성"
    }
    func configUI() {
        view.backgroundColor = .systemBackground
        commentEditView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentEditView)
        
        let commonSpacing: CGFloat = 20
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            commentEditView
                .topAnchor
                .constraint(equalTo: safeArea.topAnchor, constant: commonSpacing),
            commentEditView
                .leadingAnchor
                .constraint(equalTo: safeArea.leadingAnchor, constant: commonSpacing),
            commentEditView
                .bottomAnchor
                .constraint(equalTo: safeArea.bottomAnchor, constant: -commonSpacing),
            commentEditView
                .trailingAnchor
                .constraint(equalTo: safeArea.trailingAnchor, constant: -commonSpacing)
        ])
    }
    
    func setupInputView() {
        commentEditView.inputView = keyBoardView
        commentEditView.inputView?.autoresizingMask = .flexibleHeight
    }
}
