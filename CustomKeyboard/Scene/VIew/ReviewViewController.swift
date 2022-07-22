//
//  ReviewViewController.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/23.
//

import UIKit

final class ReviewViewController: UIViewController {
  

  override func viewDidLoad() {
    super.viewDidLoad()
    setDisplay()
    
  }
  
  private func setDisplay(){
    view.backgroundColor = .white
    setNavigationBar()
    setConstraints()
  }
    
  private func setNavigationBar(){
    let naviBar = UINavigationBar(frame: .init(x: 0, y: view.safeAreaInsets.top + 40, width: view.frame.width, height: 20))
    naviBar.isTranslucent = false
    naviBar.backgroundColor = .secondarySystemFill
    let naviItem = UINavigationItem(title: "리뷰 남기기")
    naviItem.rightBarButtonItem = UIBarButtonItem(title: "게시", image: nil, primaryAction: sumbit, menu: nil)
    naviItem.rightBarButtonItem?.isEnabled = false
    naviItem.leftBarButtonItem = UIBarButtonItem(title: "취소", image: nil, primaryAction: cancel, menu: nil)
    naviBar.items = [naviItem]
    view.backgroundColor = .white
    view.addSubview(naviBar)
  }
  
  private lazy var cancel = UIAction { _ in
    self.dismiss(animated: true)
  }
  
  private let sumbit = UIAction { _ in
    print("dd")
  }
  
  
  private func setConstraints() {

  }
  
  
}
