//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
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
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        viewModel.delegate = self
        viewModel.fetchReviewList()
    }
}

extension ViewController: ViewModelDelegate {
    func clearText() {
        DispatchQueue.main.async { [weak self] in
            guard let presentButton = self?.commentButton.stackView.arrangedSubviews[1] as? UITextField else { return }
            presentButton.text = nil
        }
        
        DispatchQueue.main.async {
            self.updateClearView()
        }
    }
    
    func viewModel(didEndFetchReviewList viewModel: ViewModel) {
        reviewListTableView.reloadData()
    }
    
    private func updateClearView() {
        UIView.animate(withDuration: 0.5) {
            let sendButton = self.commentButton.stackView.arrangedSubviews[2]
            sendButton.isHidden = true
            let profileImage = self.commentButton.stackView.arrangedSubviews[0]
            profileImage.isHidden = false
            self.commentButton.stackView.layoutIfNeeded()
        }
    }
}

extension ViewController: UITableViewDataSource {
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

private extension ViewController {
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

extension ViewController: CommentButtonDelegate {
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

extension ViewController: CommentEditDelegate {
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
            let sendButton = self.commentButton.stackView.arrangedSubviews[2]
            sendButton.isHidden = false
            let profileImage = self.commentButton.stackView.arrangedSubviews[0]
            profileImage.isHidden = true
        }
    }
}
