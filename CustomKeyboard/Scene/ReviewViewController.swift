//
//  ReviewViewController.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

class ReviewViewController: UIViewController {
    private let reviewTableView = UITableView()
    private let reviewList: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension ReviewViewController {
    private func attribute() {
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
        reviewTableView.register(ReviewTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "ReviewTableViewHeader")
        
        navigationItem.title = "리뷰"
    }
    
    private func layout() {
        [
            reviewTableView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        reviewTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        reviewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        reviewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - TableViewDataSource, TableViewDelegate
extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        
        cell.setup()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReviewTableViewHeader") as? ReviewTableViewHeader else { return UIView() }
        
        header.setup()
        header.reviewTextField.delegate = self
        
        return header
    }
}

// MARK: - TextFieldDelegate
extension ReviewViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // TODO: - KeyboardViewController와 연결
        let vc = KeyboardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
