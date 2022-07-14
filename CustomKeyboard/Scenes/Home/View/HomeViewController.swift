//
//  HomeViewController.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/12.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    var reviewList: [ReviewModel] = []
    
    lazy var reviewTableview: UITableView = {
        var tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(
            ReviewTableviewCell.self,
            forCellReuseIdentifier: ReviewTableviewCell.identifier
        )
        tableview.rowHeight = 100
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(tapAddButton)
        )
        setConstraints()
        homeViewModel.reloadReviewList()
        bind()
    }
    
    func setConstraints() {
        view.addSubview(reviewTableview)
        NSLayoutConstraint.activate([
        reviewTableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        reviewTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        reviewTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        reviewTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func bind(){
        self.homeViewModel.reviewList.bind { review in
//            print("<<<<<", review)
            self.reviewList = review
            DispatchQueue.main.async {
              self.reviewTableview.reloadData()
            }
        }
    }

    @objc func tapAddButton(){
        self.navigationController?.pushViewController(CreateReviewViewController(), animated: false)
    }
}

extension HomeViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewTableviewCell.identifier,
            for: indexPath
        ) as? ReviewTableviewCell  else {
            return UITableViewCell()
        }
        cell.userImage.image = UIImage(systemName: "heart")
        cell.userName.text = reviewList[indexPath.row].userName
        cell.condent.text = reviewList[indexPath.row].content
        return cell
    }
}
