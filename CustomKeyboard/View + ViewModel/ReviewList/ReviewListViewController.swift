//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commentButton.presentTextView.text = viewModel.keyboardViewModel.result.value
        DispatchQueue.main.async {
            self.commentButton.toggleAnimation(self.commentButton.presentTextView.text.isEmpty)
        }
        super.viewWillAppear(animated)
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
                    self.commentButton.presentTextView.text = ""
                    
                    self.viewModel.keyboardViewModel.clearAll()
                    self.viewModel.writeViewModel.clearAll()
                }
            }
        }
    }
    
    func bindPresentController() {
        viewModel.present.bind { vc in
            guard let vc = vc as? WriteController else {
                return
            }
            let nvc = UINavigationController(rootViewController: vc)
            nvc.modalPresentationStyle = .fullScreen
            self.present(nvc, animated: true)
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
        cell.viewModel = ReviewListTableViewCellViewModel(review: review)
        cell.setupView()

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
            commentButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            commentButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16.0),
            commentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            commentButton.heightAnchor.constraint(equalToConstant: 50),
            
            reviewListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            reviewListTableView.topAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 16.0),
            reviewListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            reviewListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
