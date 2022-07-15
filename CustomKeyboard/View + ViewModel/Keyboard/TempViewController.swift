//
//  TempViewController.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import UIKit

class TempViewController: UIViewController {
    let keyboardView = KeyboardView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        keyboardView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        keyboardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
}
