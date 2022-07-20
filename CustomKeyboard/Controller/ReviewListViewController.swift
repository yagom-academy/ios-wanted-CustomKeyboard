//
//  ReviewListCell.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/11.
//

import UIKit

final class ReviewListViewController: UIViewController {
    
    // MARK: - Properties
    private let reviewListViewModel = ReviewListViewModel()
    
    // MARK: - ViewProperteis
    private lazy var writeReviewButtonView: WriteReviewButtonView = {
        let writeReviewButtonView = WriteReviewButtonView()
        
        return writeReviewButtonView
    }()
    
    private lazy var reviewListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor.gray
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ReviewListCell.self, forCellReuseIdentifier: ReviewListCell.identifier)
        
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListViewModel.tableViewUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.reviewListTableView.reloadSections(IndexSet(0...0), with: .automatic)
            }
        }
        
        reviewListViewModel.sendButtonStateUpdate = { [weak self] in
            self?.writeReviewButtonView.writeReviewButton.setTitle(self?.reviewListViewModel.userWriteReview, for: .normal)
            self?.writeReviewButtonView.showSendReviewButton(isCanSend: true)
        }
        configureSubViews()
        setConstraints()
        fetchNewReviews()
        configureTarget()
    }
    
    // MARK: - Method
    private func fetchNewReviews() {
        reviewListViewModel.fetchReviews()
    }
    
    private func configureTarget() {
        writeReviewButtonView.writeReviewButton.addTarget(self, action: #selector(tapWriteReviewbutton), for: .touchUpInside)
        writeReviewButtonView.sendReviewButton.addTarget(self, action: #selector(tapSendReviewButton), for: .touchUpInside)
    }
}

// MARK: - UI
extension ReviewListViewController {
    private func configureSubViews() {
        [writeReviewButtonView, reviewListTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        setConstraintsOfReviewListTableView()
        setConstraintsOfWriteReviewButton()
    }
    
    private func setConstraintsOfReviewListTableView() {
        NSLayoutConstraint.activate([
            reviewListTableView.topAnchor.constraint(equalTo: writeReviewButtonView.bottomAnchor),
            reviewListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            reviewListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setConstraintsOfWriteReviewButton() {
        NSLayoutConstraint.activate([
            writeReviewButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            writeReviewButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            writeReviewButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            writeReviewButtonView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ReviewListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewListViewModel.reviewsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListCell.identifier, for: indexPath) as? ReviewListCell else { return UITableViewCell() }
        
        let reviewModel = reviewListViewModel.reviewAtIndex(index: indexPath.row)
        cell.configureCell(with: reviewModel)
        
        return cell
    }
}

// MARK: - TargetMethod
extension ReviewListViewController {
    @objc private func tapWriteReviewbutton() {
        let vc = WriteReviewViewController()
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc private func tapSendReviewButton() {
        reviewListViewModel.sendReview()
    }
}

// MARK: - WriteReviewViewControllerDelegate
extension ReviewListViewController: WriteReviewViewControllerDelegate {
    func sendReviewMessage(review: String) {
        reviewListViewModel.userWriteReview = review
    }
}
