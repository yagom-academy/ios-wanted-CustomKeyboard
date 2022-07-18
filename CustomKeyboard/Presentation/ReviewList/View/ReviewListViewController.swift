//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
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
        resisterGestrueRecognizer()
        reviewListView.postButton.addTarget(self, action: #selector(postDataToServer), for: .touchUpInside)
    }
    
    func resisterGestrueRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressReviewInput))
        reviewListView.reviewInputLabel.isUserInteractionEnabled = true
        reviewListView.reviewInputLabel.addGestureRecognizer(tap)
    }
    
    func getDataFromServer() {
        ReviewDataManager.shared.getData("https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") { result in
            self.reviewList = result
            DispatchQueue.main.async {
                self.reviewListView.tableView.reloadData()
            }
        }
    }
    
    @objc func postDataToServer() {
        ReviewDataManager.shared.postData("https://api.plkey.app/tmp/theme/PLKEY0-L-81/review", "hi")
    }
    
    @IBAction func pressReviewInput(_ sender: UITapGestureRecognizer) {
        let keyboardViewController = KeyboardViewController()
        keyboardViewController.delegate = self
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
        cell.timeLabel.text = makeTimeLine(reviewList?.data[indexPath.row].createdAt ?? "")
        
        return cell
    }
    
    func makeTimeLine(_ time : String) -> String {
        // 우선 현재 시간이랑 차이를 구해야함
        
        // 현재 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh"
        let current = formatter.string(from: Date()).split(separator: " ")
        let currentDate = current[0]
        let currentHour = current[1]
        
        // 주어진 시간
        let splitReviewDate = time.split(separator: "T")
        let reviewDate = splitReviewDate[0]
        let reviewTime = splitReviewDate[1]
        let splitReviewTime = reviewTime.split(separator: ":")
        let reviewHour = isFirstZero(String(splitReviewTime[0]))
        let reviewMinute = isFirstZero(String(splitReviewTime[1]))
        
        if currentDate != reviewDate {
            return String(reviewDate)
        } else { // 하루 이내
            if currentHour != reviewHour {
                // 분 단위 표시
                 return ("\(reviewMinute)분 전")
            } else {
                // 시간 단위 표시
                 return ("\(reviewHour)시간 전")
            }
        }
    }
    
    func isFirstZero(_ timeString : String) -> String {
        if timeString.first == "0" {
            return String(timeString.dropFirst())
        } else {
            return String(timeString)
        }
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

extension ReviewListViewController : KeyboardViewControllerDelegate {
    func updateLabelText(_ reviewText: String?) {
        reviewListView.reviewInputLabel.text = reviewText
    }
}
