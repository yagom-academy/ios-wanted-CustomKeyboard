//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class ReviewListViewController: UIViewController {

    private var reviewTableView: UITableView = {
        let reviewTableView = UITableView()
        return reviewTableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "Cell")
        reviewTableView.register(ReviewListHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerCell")
    }
    
    func setLayout() {
        view.backgroundColor = .white
        view.addSubview(reviewTableView)
        reviewTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            reviewTableView.topAnchor.constraint(equalTo: view.topAnchor),
            reviewTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            reviewTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            reviewTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
}

extension ReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReviewTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerCell") as! ReviewListHeaderView
        headerCell.delegate = self
        return headerCell
    }
}

extension ReviewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension ReviewListViewController: PresentButtonSelectable {
    func presentButtonStatus() {
        print("페이지 이동")
    }
}
