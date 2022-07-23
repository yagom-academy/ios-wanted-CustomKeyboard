//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

final class HomeViewController: UIViewController {
  
  private let viewModel = HomeViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableView()
    setConstraints()
    setupKeyboardActions()
    setData()
    setReviewButtonAction()
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
    tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.cellID)
    tableView.estimatedRowHeight = 120
    tableView.rowHeight = UITableView.automaticDimension
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let reviewBannerView: HomeBannerView = {
    let view = HomeBannerView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private func setConstraints() {
    view.addSubview(reviewBannerView)
    view.addSubview(reviewTableView)
    
    NSLayoutConstraint.activate([
      reviewBannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      reviewBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      reviewBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      reviewBannerView.heightAnchor.constraint(equalToConstant: 60),
    ])
    
    NSLayoutConstraint.activate([
      reviewTableView.topAnchor.constraint(equalTo: reviewBannerView.bottomAnchor, constant: 5),
      reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupKeyboardActions() {
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    gestureRecognizer.cancelsTouchesInView = false
    view.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func setReviewButtonAction() {
    reviewBannerView.buttonDidTap = {
      let reivewViewController = ReviewViewController(viewModel: self.viewModel)
      reivewViewController.modalPresentationStyle = .fullScreen
      self.present(reivewViewController, animated: true)
    }
  }
  
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.reviewList.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellID, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
    
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
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}


