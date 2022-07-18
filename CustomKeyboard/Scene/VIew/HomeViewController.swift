//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setConstraints()
        setData()
        reviewTextField.done = { text in
            print(text)
            self.viewModel.makeReview(review: text) { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    private func setData(){
        viewModel.viewReviewList()
        viewModel.reviewList.bind { reviews in
            DispatchQueue.main.async {
                self.reviewTableView.reloadData()
            }
        }
    }
    
    private func setTableView() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    
    
    private let reviewTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellID)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let reviewTextField : ReviewTextFieldView = {
        let view = ReviewTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setConstraints() {
        view.addSubview(reviewTableView)
        view.addSubview(reviewTextField)
        
        NSLayoutConstraint.activate([
            reviewTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            reviewTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reviewTextField.bottomAnchor.constraint(equalTo: reviewTableView.topAnchor),
            reviewTextField.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: reviewTextField.bottomAnchor),
            reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellID, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        
        let model = viewModel[indexPath]
        cell.selectionStyle = .none
        cell.setupReviewData(model)
        guard let url = URL(string: model.user.profileImage) else {return cell}
        viewModel.showImage(url: url, completion: { data in
            DispatchQueue.main.async {
                cell.setProfileImage(data)
            }})
        return cell
    }
}
extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

