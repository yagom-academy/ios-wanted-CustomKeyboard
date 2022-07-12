//
//  HomeViewController.swift
//  CustomKeyboard
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        bind()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
//        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
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
