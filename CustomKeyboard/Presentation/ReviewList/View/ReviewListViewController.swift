//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

class ReviewListViewController: BaseViewController {
    
    private let reviewListView = ReviewListView()
    
    override func loadView() {
        self.view = reviewListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListView.tableView.dataSource = self
        reviewListView.reviewInputView.delegate = self
    }
    
}

extension ReviewListViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "이 테마가 마음에 드시나요?" {
            textView.text = nil
            textView.textColor = .black
        }
        let keyboardViewController = KeyboardViewController()
        present(keyboardViewController, animated: true)
    }
}

extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.identifier, for: indexPath) as? ReviewListTableViewCell else {return UITableViewCell()}
        
        return cell
    }
}
