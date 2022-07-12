//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class HomeViewController: UIViewController {
  
  let reviewTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reviewTableView.delegate = self
    reviewTableView.dataSource = self
    reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellID)
    setConstraints()
  }
  
  
  private func setConstraints() {
    view.addSubview(reviewTableView)
    reviewTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      reviewTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
//    reviewTableView.frame = view.safeAreaLayoutGuide.topAnchor
  }
}

extension HomeViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellID, for: indexPath) as! ReviewTableViewCell
    
    return cell
  }
}

extension HomeViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
}

