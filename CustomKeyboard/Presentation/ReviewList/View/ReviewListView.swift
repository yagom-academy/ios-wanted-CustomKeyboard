//
//  ReviewListView.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

final class ReviewListView: UIView {
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")

        return image
    }()
    
    lazy var reviewInputTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "이 테마가 마음에 드시나요?"
        return textField
    }()
    
    lazy var reviewInputHorizontalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var verticalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        lazy var tableView = UITableView()
        tableView.register(ReviewListTableViewCell.self, forCellReuseIdentifier: ReviewListTableViewCell.identifier)
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)
        
        [reviewInputHorizontalStackView,tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.addArrangedSubview($0)
        }
        
        [profileImage,reviewInputTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            reviewInputHorizontalStackView.addArrangedSubview($0)
        }

    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            reviewInputHorizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            reviewInputHorizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: reviewInputHorizontalStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
            
            
        ])
    }
}
