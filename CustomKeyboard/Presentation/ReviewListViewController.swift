//
//  ReviewListViewController.swift
//  CustomKeyboard
//

import UIKit

final class ReviewListViewController: BaseViewController {

    // MARK: - Properties

    private let reviewListView = ReviewListView()
    private var reviewAPIProvider = ReviewAPIProvider(networkRequester: NetworkRequester())
    
    private var reviews: [ReviewResult] = []

    // MARK: - Lifecycle

    override func loadView() {
        self.view = reviewListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchReviews()
    }

    override func setupView() {
        setTableViewDelegate()
    }

}

// MARK: - View setting methods

extension ReviewListViewController {

    private func setTableViewDelegate() {
        reviewListView.reviewTableView.dataSource = self
    }

}

extension ReviewListViewController {
    
    func fetchReviews() {
        reviewAPIProvider.fetchReviews(completion: { result in
            switch result {
            case .success(let reviews):
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.reviewListView.reviewTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

// MARK: - UITableViewDataSource

extension ReviewListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewTableViewCell.identifier,
            for: indexPath
        ) as? ReviewTableViewCell
        else {
            return UITableViewCell()
        }

        cell.setupCell(review: reviews[indexPath.row])
        return cell
    }

}

