//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    lazy var commentButton: CommentButton = {
        let button = CommentButton()
        button.delegate = self
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        makeConstraints()
    }
    
    func makeConstraints() {
        view.addSubview(commentButton)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            commentButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
//            commentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            commentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}

extension ViewController: CommentButtonDelegate {
    func present() {
        let controller = WriteController()
        self.present(controller, animated: true)
    }
}
