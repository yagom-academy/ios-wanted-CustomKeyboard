//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

final class ReviewListViewController: UIViewController {
    //MARK: - Properties
    let viewModel = ReviewListViewModel()
    
    //MARK: - UI Components
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
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(presentTapped)
        )
        button.presentTextView.addGestureRecognizer(tapGesture)
        button.sendButton.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        viewModel.fetchReviewList()
        bindTableData()
        bindPostSuccess()
        bindPresentController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commentButton.presentTextView.text = viewModel.keyboardViewModel.result.value
        let isPresentTextViewEmpty = commentButton.presentTextView.text.isEmpty
        DispatchQueue.main.async {
            self.commentButton.toggleAnimation(isPresentTextViewEmpty)
        }
        super.viewWillAppear(animated)
    }
}

//MARK: - TableView DataSource
extension ReviewListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.reviewList.value.count
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewListTableViewCell.identifier,
            for: indexPath
        ) as? ReviewListTableViewCell else { return UITableViewCell() }
        
        let review = viewModel.reviewList.value[indexPath.row]
        cell.viewModel = ReviewListTableViewCellViewModel(review: review)
        cell.setupView()
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - Bind Methods
private extension ReviewListViewController {
    func bindTableData() {
        viewModel.reviewList.bind { [weak self] list in
            DispatchQueue.main.async {
                self?.reviewListTableView.reloadData()
            }
        }
    }
    
    func bindPostSuccess() {
        viewModel.isSuccess.bind { [weak self] isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.commentButton.toggleAnimation(isSuccess)
                    self?.commentButton.presentTextView.text = ""
                    
                    self?.viewModel.keyboardViewModel.clearAll()
                    self?.viewModel.writeViewModel.clearAll()
                }
            }
        }
    }
    
    func bindPresentController() {
        viewModel.present.bind { [weak self] vc in
            guard let vc = vc as? WriteController else {
                return
            }
            
            let nvc = UINavigationController(rootViewController: vc)
            nvc.modalPresentationStyle = .fullScreen
            self?.present(nvc, animated: true)
        }
    }
}

//MARK: - @objc Methods
private extension ReviewListViewController {
    @objc func presentTapped() {
        viewModel.presentWriteController()
    }
    
    @objc func sendButtonTapped() {
        viewModel.postComment(commentButton.presentTextView.text)
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
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            commentButton
                .leadingAnchor
                .constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            commentButton
                .trailingAnchor
                .constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),
            commentButton
                .topAnchor
                .constraint(equalTo: safeArea.topAnchor, constant: 10),
            commentButton
                .heightAnchor
                .constraint(equalToConstant: 50),
            
            reviewListTableView
                .leadingAnchor
                .constraint(equalTo: safeArea.leadingAnchor),
            reviewListTableView
                .topAnchor
                .constraint(equalTo: commentButton.bottomAnchor, constant: 16.0),
            reviewListTableView
                .trailingAnchor
                .constraint(equalTo: safeArea.trailingAnchor),
            reviewListTableView
                .bottomAnchor
                .constraint(equalTo: view.bottomAnchor)
        ])
    }
}
