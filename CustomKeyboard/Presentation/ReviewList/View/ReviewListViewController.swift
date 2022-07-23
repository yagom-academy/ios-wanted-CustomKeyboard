//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
//

import UIKit
import Combine

class ReviewListViewController: BaseViewController {
    
    private let reviewListView = ReviewListView()
    var reviewList : ReviewList?
    var reviewListViewModel = ReviewListViewModel()
    var disposalbleBag = Set<AnyCancellable>()
        
    override func loadView() {
        self.view = reviewListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListView.tableView.dataSource = self
        reviewListViewModel.getDataFromServer()
        setBinding()
        resisterGestrueRecognizer()
        reviewListView.postButton.addTarget(self, action: #selector(postDataToServer), for: .touchUpInside)
    }
    
    func resisterGestrueRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressReviewInput))
        reviewListView.reviewInputLabel.isUserInteractionEnabled = true
        reviewListView.reviewInputLabel.addGestureRecognizer(tap)
    }
    
    @objc func postDataToServer() {
        reviewListViewModel.postDataToServer(reviewListView.reviewInputLabel.text ?? "")
        reviewListView.tableView.reloadData()
    }
    
    @IBAction func pressReviewInput(_ sender: UITapGestureRecognizer) {
        let keyboardViewController = KeyboardViewController()
        keyboardViewController.delegate = self
        present(keyboardViewController, animated: true)
    }
}

extension ReviewListViewController {
    func setBinding() {
        self.reviewListViewModel.$reviewList.sink {[weak self] updatedReviewList in
            self?.reviewList = updatedReviewList
            DispatchQueue.main.async {
                self?.reviewListView.tableView.reloadData()
            }
        }.store(in: &disposalbleBag)
    }
}

extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.identifier, for: indexPath) as? ReviewListTableViewCell else {return UITableViewCell()}
        cell.profileImage.image = reviewListViewModel.makeStringToImage(reviewList?.data[indexPath.row].user.profileImage ?? "")
        cell.userNameLabel.text = reviewList?.data[indexPath.row].user.userName
        cell.reviewTextLabel.text = reviewList?.data[indexPath.row].content
        cell.timeLabel.text = reviewListViewModel.makeTimeLine(reviewList?.data[indexPath.row].createdAt ?? "")
        
        return cell
    }
}

extension ReviewListViewController : KeyboardViewControllerDelegate {
    func updateLabelText(_ reviewText: String?) {
        guard let reviewText = reviewText else {
            return
        }
        reviewListView.reviewInputLabel.text = reviewText
    }
}
