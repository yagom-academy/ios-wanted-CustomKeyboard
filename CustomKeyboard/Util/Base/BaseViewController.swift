//
//  BaseViewController.swift
//  CustomKeyboard
//
//  Created by 이윤주 on 2022/07/12.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupView()
    }

    func style() {
        view.backgroundColor = .white
    }

    func setupView() {}
}
