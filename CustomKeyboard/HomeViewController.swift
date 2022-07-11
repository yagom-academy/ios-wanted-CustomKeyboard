//
//  HomeViewController.swift
//  CustomKeyboard
//

import UIKit

class HomeViewController: UIViewController {

    var reviewList = [Review]()
    let networkManager = NetworkManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        networkManager.downloadReview(closure: { reviewData in
            self.reviewList = reviewData.data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }
}

// MARK: -

private extension HomeViewController {
    
    func configure() {
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = reviewList[indexPath.row].user.userName
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
