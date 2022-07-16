//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit
import Combine

class ReviewListViewController: UIViewController {
    
    private lazy var reviewListTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(
            ReviewListTableViewCell.self,
            forCellReuseIdentifier: ReviewListTableViewCell.identifier
        )
        return tableView
    }()
    
    lazy var commentButton: CommentButton = {
        let button = CommentButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentTapped))
        button.presentTextView.addGestureRecognizer(tapGesture)
        
        button.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func presentTapped() {
        viewModel.presentWriteController()
    }
    
    @objc func sendButtonTapped() {
        viewModel.postComment(commentButton.presentTextView.text)
    }
    
    let viewModel = ReviewListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        viewModel.fetchReviewList()
        bindTableData()
        bindPostSuccess()
        bindPresentController()
        bindResultText()
    }
    
    func bindTableData() {
        viewModel.reviewList.bind { list in
            DispatchQueue.main.async {
                self.reviewListTableView.reloadData()
            }
        }
    }
    
    func bindPostSuccess() {
        viewModel.isSuccess.bind { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.commentButton.toggleAnimation(isSuccess)
                }
            }
        }
    }
    
    func bindPresentController() {
        viewModel.present.bind { vc in
            guard let vc = vc as? WriteController else {
                return
            }
            self.present(vc, animated: true)
        }
    }
    
    func bindResultText() {
        viewModel.resultText.bind { result in
            self.commentButton.presentTextView.text = result
        }
    }
}

//MARK: - CommentEditDelegate
extension ReviewListViewController: CommentEditDelegate {
    var commentValue: String? {
        get {
            guard let textfield = commentButton.stackView.arrangedSubviews[1] as? UITextView else { return "" }
            return textfield.text
        }
        set {
            guard let textfield = commentButton.stackView.arrangedSubviews[1] as? UITextView else { return }
            textfield.text = newValue
            commentButton.toggleAnimation(false)
            
        }
    }
}

//MARK: - TableView DataSource
extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewList.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewListTableViewCell.identifier,
            for: indexPath
        ) as? ReviewListTableViewCell else { return UITableViewCell() }
        
        let review = viewModel.reviewList.value[indexPath.row]
        cell.setupView(review: review)

        return cell
    }
}

//MARK: - View Configure
private extension ReviewListViewController {
    func setupLayout() {
        [
            commentButton,
            reviewListTableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            commentButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            commentButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            commentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            commentButton.heightAnchor.constraint(equalToConstant: 50),
            
            reviewListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            reviewListTableView.topAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 16.0),
            reviewListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            reviewListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
