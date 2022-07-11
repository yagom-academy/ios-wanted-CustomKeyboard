//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

class ReviewListViewController: BaseViewController {
    
    private let reviewListView = ReviewListView()
    
    override func loadView() {
        self.view = reviewListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListView.tableView.dataSource = self
        reviewListView.tableView.delegate = self
    }
}

extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.identifier, for: indexPath) as? ReviewListTableViewCell else {return UITableViewCell()}
        
        return cell
    }
}

extension ReviewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1
    }
}
