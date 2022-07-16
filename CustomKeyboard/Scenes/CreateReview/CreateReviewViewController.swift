//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/12.
//

import UIKit

class CreateReviewViewController: UIViewController {
    
    let createReviewViewModel = CreateReviewViewModel()
    let homeViewModel = HomeViewModel(networkService: NetworkService())
    
    lazy var textfield: UITextField = {
        var textfield = UITextField()
        textfield.backgroundColor = .gray
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapDoneButton)
        )
        setConstraints()
    }
    func setConstraints() {
        view.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textfield.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    @objc func tapDoneButton(){
        guard let condent = textfield.text else { return }
        createReviewViewModel.uploadReview(condent: condent) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
