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
        button.delegate = self
        return button
    }()
    
    let viewModel = ReviewListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        viewModel.delegate = self
        viewModel.fetchReviewList()
    }
}

//MARK: - ViewModel Delegate
extension ReviewListViewController: ReviewListViewModelDelegate {
    func clearText() {
        DispatchQueue.main.async { [weak self] in
            guard let presentButton = self?.commentButton.stackView.arrangedSubviews[1] as? UITextField else { return }
            presentButton.text = nil
        }
        
        DispatchQueue.main.async {
            self.updateClearView()
        }
    }
    
    func viewModel(didEndFetchReviewList viewModel: ReviewListViewModel) {
        reviewListTableView.reloadData()
    }
    
    private func updateClearView() {
        UIView.animate(withDuration: 0.5) {
            self.commentButton.showProfileImage()
            self.commentButton.stackView.layoutIfNeeded()
        }
    }
}

//MARK: - CommentButton Delegate
extension ReviewListViewController: CommentButtonDelegate {
    func present() {
        let controller = WriteController()
        controller.delegate = self
        self.present(controller, animated: true)
    }
    
    func post() {
        guard let commentView = commentButton.stackView.arrangedSubviews[1] as? UITextField,
              let comment = commentView.text else { return }
        viewModel.postComment(comment)
        
    }
}

//MARK: - CommentEditDelegate
extension ReviewListViewController: CommentEditDelegate {
    var commentValue: String? {
        get {
            guard let textfield = commentButton.stackView.arrangedSubviews[1] as? UITextField else { return "" }
            return textfield.text
        }
        set {
            guard let textfield = commentButton.stackView.arrangedSubviews[1] as? UITextField else { return }
            textfield.text = newValue
            updateInputView()
        }
    }
    
    private func updateInputView() {
        UIView.animate(withDuration: 0.5) {
            self.commentButton.hideProfileImage()
            self.commentButton.layoutIfNeeded()
        }
    }
}

//MARK: - TableView DataSource
extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewListTableViewCell.identifier,
            for: indexPath
        ) as? ReviewListTableViewCell else { return UITableViewCell() }
        
        let review = viewModel.reviewList[indexPath.row]
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
            commentButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            commentButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            commentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            commentButton.heightAnchor.constraint(equalToConstant: 50),
            
            reviewListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            reviewListTableView.topAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 16.0),
            reviewListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            reviewListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
