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
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return image
    }()
    
    lazy var reviewInputView: UITextView = {
       let view = UITextView()
        view.backgroundColor = UIColor(red: 242/255, green: 243/255, blue: 247/255, alpha: 1)
        view.layer.cornerRadius = 20
        view.text = "이 테마가 마음에 드시나요?"
        view.textColor = .gray
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    
    lazy var reviewInputHorizontalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var verticalStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        lazy var tableView = UITableView()
        tableView.register(ReviewListTableViewCell.self, forCellReuseIdentifier: ReviewListTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
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
        
        [profileImage,reviewInputView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            reviewInputHorizontalStackView.addArrangedSubview($0)
        }
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: reviewInputHorizontalStackView.centerYAnchor),
            reviewInputView.centerYAnchor.constraint(equalTo: reviewInputHorizontalStackView.centerYAnchor),
            reviewInputHorizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            reviewInputHorizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 20),
            verticalStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
