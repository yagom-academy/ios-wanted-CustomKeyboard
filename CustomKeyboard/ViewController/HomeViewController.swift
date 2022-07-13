//
//  HomeViewController.swift
//  CustomKeyboard
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    private let viewModel = HomeViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        viewModel.fetch()
    }
}

// MARK: - Private

extension HomeViewController {
    private func configure() {
        configureTableView()
        configureButtons()
        bind()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
//        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
    }
    
    private func configureButtons() {
        [reviewButton, submitButton].forEach { button in
            button?.backgroundColor = UIColor.systemGray6
            button?.layer.cornerRadius = 15
            button?.setTitleColor(UIColor.darkGray, for: .normal)
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
    }
    
    private func bind() {
        viewModel.$reviewList
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let review = viewModel.review(at: indexPath.row)
        cell.configureCell(review)
        return cell
    }
}
