//
//  ReviewViewController.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

class ReviewViewController: UIViewController {
    private let reviewTableView = UITableView()
    private var reviewList: [Review] = []
    private var viewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        bind(viewModel)
        viewModel.getReview { [weak self] reviews in
            guard let self = self  else { return }
            self.reviewList = reviews.reviewData
            DispatchQueue.main.async {
                self.reviewTableView.reloadData()
            }
        }
    }
}

extension ReviewViewController {
    private func attribute() {
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
        reviewTableView.register(ReviewTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "ReviewTableViewHeader")
        
        navigationItem.title = "리뷰"
    }
    
    private func layout() {
        [
            reviewTableView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        reviewTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bind(_ viewModel: ReviewViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - TableViewDataSource, TableViewDelegate
extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        
        let review = reviewList[indexPath.row]
        cell.setup(review)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReviewTableViewHeader") as? ReviewTableViewHeader else { return UIView() }
        
        header.setup()
        header.reviewTextField.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 84
    }
}

// MARK: - TextFieldDelegate
extension ReviewViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let vc = KeyboardViewController()
        navigationController?.pushViewController(vc, animated: true)
        textField.resignFirstResponder()
    }
}
