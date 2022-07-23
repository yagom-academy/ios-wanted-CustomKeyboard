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
    private var myContent: [String] = [] {
        didSet {
            reviewTableView.reloadData()
        }
    }
    private var viewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        bind(viewModel)
        viewModel.getReview { [weak self] result in
            guard let self = self  else { return }
            switch result {
            case .success(let reviews):
                self.reviewList = reviews.reviewData
                self.reviewList = self.reviewList.sorted(by: { r1, r2 in
                    r1.createdAt.compare(r2.createdAt) == .orderedDescending
                })
                DispatchQueue.main.async {
                    self.reviewTableView.reloadData()
                }
            case .failure(_) :
                print(Error.self)
            }
        }
    }
}

extension ReviewViewController {
    private func attribute() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(cellType: ReviewTableViewCell.self)
        reviewTableView.register(headerFooterType: ReviewTableViewHeader.self)
        
        navigationItem.title = "리뷰"
    }
    
    private func layout() {
        [
            reviewTableView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
        let cell = tableView.dequeueReusableCell(cellType: ReviewTableViewCell.self, indexPath: indexPath)
        
        let review = reviewList[indexPath.row]
        cell.setup(review)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReviewTableViewHeader.identifier) as? ReviewTableViewHeader else { return UIView() }
        
        header.setup()
        header.reviewTextField.delegate = self
        header.delegate = self
        
        if !myContent.isEmpty {
            header.reviewTextField.text = myContent.last!
        }
        
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
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        textField.resignFirstResponder()
    }
}

extension ReviewViewController: PassContentDelegate {
    func sendReviewData(content: String) {
        myContent.append(content)
    }
}

extension ReviewViewController: PassReviewDelegate {
    func sendReviewData(review: Review) {
        reviewList.append(review)
        reviewList = reviewList.sorted(by: { r1, r2 in
            r1.createdAt.compare(r2.createdAt) == .orderedDescending
        })
        reviewTableView.reloadData()
    }
}
