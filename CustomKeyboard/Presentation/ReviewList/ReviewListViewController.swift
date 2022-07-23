//
//  ReviewListViewController.swift
//  CustomKeyboard
//

import UIKit

final class ReviewListViewController: UIViewController {

    // MARK: - Properties

    private let reviewListView = ReviewListView()
    private var reviewAPIProvider: ReviewAPIProviderType?
    private var profileImageProvider: ProfileImageProviderType?
    
    private var reviews: [ReviewResult] = []

    // MARK: - Lifecycle
    
    static func instantiate(
        with reviewAPIProvider: ReviewAPIProviderType,
        _ profileImageProvider: ProfileImageProviderType
    ) -> ReviewListViewController {
        let viewController = ReviewListViewController()
        viewController.reviewAPIProvider = reviewAPIProvider
        viewController.profileImageProvider = profileImageProvider
        return viewController
    }

    override func loadView() {
        reviewListView.delegate = self
        self.view = reviewListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        fetchReviews()
    }

}

// MARK: - View presenting methods

extension ReviewListViewController: KeyboardViewPresentable {

    func presentKeyboardViewController() {
        let viewController = KeyboardViewController()
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }

}

// MARK: - View setting methods

extension ReviewListViewController {

    private func setTableViewDelegate() {
        reviewListView.reviewTableView.dataSource = self
    }

}

// MARK: - Review networking methods

extension ReviewListViewController {
    
    func fetchReviews() {
        reviewAPIProvider?.fetchReviews(completion: { result in
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

extension ReviewListViewController: ReviewUploadable {
    
    func uploadReview(with contents: String) {
        reviewAPIProvider?.upload(review: contents) { result in
            switch result {
            case.success(_):
                self.reviews.append(
                    ReviewResult.init(
                        user: User.init(
                            userName: Text.writterName,
                            profileImageURL: Text.noImage
                        ),
                        content: contents,
                        createdAt: Date.now.description
                    )
                )
                DispatchQueue.main.async {
                    self.reviewListView.reviewTableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
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
        
        guard review.user.profileImageURL != Text.noImage else {
            return cell
        }
        
        profileImageProvider?.fetchImage(from: review.user.profileImageURL) { result in
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

// MARK: - NameSpaces

extension ReviewListViewController {

    private enum Text {
        static let writterName = "당신"
        static let noImage = "noImage"
    }

}
