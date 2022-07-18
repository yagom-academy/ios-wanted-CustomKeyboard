//
//  BaseViewController.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
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
