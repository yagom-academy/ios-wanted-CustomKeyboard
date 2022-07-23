//
//  ReviewViewController.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/23.
//

import UIKit

final class ReviewViewController: UIViewController {
  
  private var viewModel: ReviewViewModel
  
  init(viewModel: ReviewViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setDisplay()
  }
  
  private func setDisplay(){
    view.backgroundColor = .white
    setNavigationBar()
    setConstraints()
    setTextViewBinding()
  }

  private let reviewContentView: ReviewContentView = {
    let reviewContentView = ReviewContentView()
    reviewContentView.translatesAutoresizingMaskIntoConstraints = false
    return reviewContentView
  }()
  
  
  private lazy var naviItem: UINavigationItem = {
    let naviItem = UINavigationItem(title: "리뷰 남기기")
    naviItem.rightBarButtonItem = UIBarButtonItem(title: "게시", image: nil, primaryAction: sumbit, menu: nil)
    naviItem.rightBarButtonItem?.isEnabled = false
    naviItem.leftBarButtonItem = UIBarButtonItem(title: "취소", image: nil, primaryAction: cancel, menu: nil)
    return naviItem
  }()
  
  private func setNavigationBar(){
    let naviBar = UINavigationBar(frame: .init(x: 0, y: view.safeAreaInsets.top + 40, width: view.frame.width, height: 40))
    naviBar.isTranslucent = false
    naviBar.backgroundColor = .secondarySystemFill
    naviBar.items = [naviItem]
    view.backgroundColor = .white
    view.addSubview(naviBar)
  }
  
  private func setTextViewBinding() {
    reviewContentView.startEditing = { input in
      guard let input = input else {return}
      if input.count > 0 {
        self.naviItem.rightBarButtonItem?.isEnabled = true
      }else {
        self.naviItem.rightBarButtonItem?.isEnabled = false
      }
    }
    
    reviewContentView.doneEditing = { input in
      if self.naviItem.rightBarButtonItem?.isEnabled == true {
        self.uploadReview()
      }
    }
  }
  
  private lazy var cancel = UIAction { _ in
    self.dismiss(animated: true)
  }
  
  private lazy var sumbit = UIAction { _ in
    self.uploadReview()
  }
  
  private func uploadReview() {
    self.viewModel.makeReview(review: self.reviewContentView.reviewTextView.text) { _ in
      DispatchQueue.main.async {
        self.dismiss(animated: true)
      }
    }
  }
  
  private func setConstraints() {
    view.addSubview(reviewContentView)
    NSLayoutConstraint.activate([
      reviewContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.safeAreaInsets.top + 40),
      reviewContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 1/2),
      reviewContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      reviewContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
  }
}
