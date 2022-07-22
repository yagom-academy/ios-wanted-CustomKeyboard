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
    setKeyboardNotification()
    setupKeyboardActions()
    setData()
    setTextField()

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
  
  private lazy var reviewTextField : ReviewTextFieldView = {
    let view = ReviewTextFieldView(frame: CGRect(x: 0, y: Int(view.frame.size.height) - 60, width: Int(view.frame.width), height: 60))
    return view
  }()
  
  private func setConstraints() {
    view.addSubview(reviewTableView)
    view.addSubview(reviewTextField)
    NSLayoutConstraint.activate([
      reviewTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setKeyboardNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  
  @objc private func adjustInputView(noti: Notification) {
    guard let userInfo = noti.userInfo else { return }
    guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
    let adjustmentHeight = (keyboardFrame.height + (reviewTextField.frame.height/2)) - view.safeAreaInsets.bottom
    let originalYCoord = CGFloat(Int(view.frame.size.height) - 60)
    
    if noti.name == UIResponder.keyboardWillShowNotification &&  reviewTextField.frame.origin.y == originalYCoord{
      reviewTextField.frame.origin.y -= adjustmentHeight
      reviewTextField.layoutIfNeeded()
    } else {
      reviewTextField.frame.origin.y = originalYCoord
      reviewTextField.layoutIfNeeded()
    }
  }

  private func setupKeyboardActions() {
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    gestureRecognizer.cancelsTouchesInView = false
    view.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func setTextField() {
    reviewTextField.done = { text in
      print(text)
      self.viewModel.makeReview(review: text) { error in
        if let error = error {
          print(error)
        }
      }
    }
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


