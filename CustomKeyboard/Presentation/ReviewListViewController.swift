//
//  ReviewListViewController.swift
//  CustomKeyboard
//

import UIKit

final class ReviewListViewController: BaseViewController {

    // MARK: - Properties

    private let reviewListView = ReviewListView()
    private let reviewAPIProvider = ReviewAPIProvider(networkRequester: NetworkRequester())
    private let profileImageProvider = ProfileImageProvider(networkRequester: NetworkRequester())
    
    private var reviews: [ReviewResult] = []

    // MARK: - Lifecycle

    override func loadView() {
        reviewListView.delegate = self
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

// MARK: - objc Methods

extension ReviewListViewController: KeyboardViewPresentable {

    func presentKeyboardViewController() {
        let viewController = KeyboardViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }

}

extension ReviewListViewController: ReviewUploadable {
    
    func uploadReview(with contents: String) {
        reviewAPIProvider.upload(review: contents) { result in
            switch result {
            case.success(let success):
                self.reviews.append(ReviewResult.init(user: User.init(userName: "당신", profileImage: "noImage"), content: contents, createdAt: Date.now.description))
                DispatchQueue.main.async {
                    self.reviewListView.reviewTableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
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

        let review = reviews[indexPath.row]
        cell.setupCell(review: review)
        profileImageProvider.fetchImage(from: review.user.profileImage) { result in
            switch result {
            case .success(let profileImage):
                cell.setupProfileImage(profileImage)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return cell
    }

}

