//
//  ReviewListCell.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/11.
//

import UIKit

final class ReviewListViewController : UIViewController {
    
    private let reviewListViewModel = ReviewListViewModel()
    
    private lazy var reviewListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor.gray
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(ReviewListCell.self, forCellReuseIdentifier: "ReviewListCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListViewModel.fethAllReviews { [weak self] success in
            if success {
                DispatchQueue.main.async {                
                    self?.reviewListTableView.reloadData()
                }
            }
        }
        
        setUpTableView()
        print(reviewListTableView.rowHeight)
    }
    
    func setUpTableView() {
        view.addSubview(reviewListTableView)
        reviewListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            reviewListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ReviewListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewListViewModel.reviewsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListCell.identifier, for: indexPath) as? ReviewListCell else { return UITableViewCell() }
        
        let reviewModel = reviewListViewModel.reviewAtIndex(index: indexPath.row)
        cell.configure(with: reviewModel)
        
        return cell
    }
}
