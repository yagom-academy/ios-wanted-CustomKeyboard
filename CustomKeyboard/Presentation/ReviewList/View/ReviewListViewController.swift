//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

class ReviewListViewController: BaseViewController {
    
    private let reviewListView = ReviewListView()
    
    var reviewList : ReviewList?
    
    override func loadView() {
        self.view = reviewListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListView.tableView.dataSource = self
        getDataFromServer()
        
        // test
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressReviewInput))
        reviewListView.reviewInputLabel.isUserInteractionEnabled = true
        reviewListView.reviewInputLabel.addGestureRecognizer(tap)
//        postDataToServer()
    }
    
    func getDataFromServer() {
        ReviewDataManager.shared.getData("https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") { result in
            self.reviewList = result
            DispatchQueue.main.async {
                self.reviewListView.tableView.reloadData()
            }
        }
    }
    
    func postDataToServer() {
        ReviewDataManager.shared.postData("https://api.plkey.app/tmp/theme/PLKEY0-L-81/review", "hi")
    }
    
    @IBAction func pressReviewInput(sender: UITapGestureRecognizer) {
        let keyboardViewController = KeyboardViewController()
        present(keyboardViewController, animated: true)
    }
    
}

extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.identifier, for: indexPath) as? ReviewListTableViewCell else {return UITableViewCell()}
        
        cell.profileImage.image = makeStringToImage(reviewList?.data[indexPath.row].user.profileImage ?? "")
        cell.userNameLabel.text = reviewList?.data[indexPath.row].user.userName
        cell.reviewTextLabel.text = reviewList?.data[indexPath.row].content
        cell.timeLabel.text = reviewList?.data[indexPath.row].createdAt
        
        return cell
    }
    
    func makeStringToImage(_ imageString : String) -> UIImage? {
        guard let url = URL(string: imageString) else {return nil}
        
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("error")
            return nil
        }
    }
}
