//
//  ReviewListCell.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/11.
//

import UIKit

final class ReviewListViewController : UIViewController {
    
    // MARK: - Properties
    private let reviewListViewModel = ReviewListViewModel()
    
    // MARK: - ViewProperteis
    private lazy var writeReviewButtonView : WriteReviewButtonView = {
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
        reviewListViewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.reviewListTableView.reloadSections(IndexSet(0...0), with: .automatic)
            }
        }
        configureSubViews()
        setConstraints()
        fetchNewReviews()
    }
    
    // MARK: - Method
    private func fetchNewReviews() {
        reviewListViewModel.fetchReviews()
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
    
    func setConstraints() {
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
