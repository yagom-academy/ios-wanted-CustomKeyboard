//
//  HomeViewController.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/12.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
    }
        
    @objc func tapAddButton(){
        self.navigationController?.pushViewController(CreateReviewViewController(), animated: false)
    }
}
