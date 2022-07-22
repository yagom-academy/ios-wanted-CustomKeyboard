//
//  ReviewListTableViewCell.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

class ReviewListTableViewCell: UITableViewCell, CellIdentifiable {
    //MARK: - Properties
    var viewModel: ReviewListTableViewCellViewModel?

    //MARK: - UI Components
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35.0
        imageView.clipsToBounds = true
        imageView.backgroundColor = .backgroundPink
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp
    func setupView() {
        nameLabel.text = viewModel?.review.user.userName
        rateLabel.text = viewModel?.review.rate
        contentLabel.text = viewModel?.review.reviewContent
        dateLabel.text = viewModel?.review.date
        viewModel?.loadImage()
        bindImage()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.cancelImageDownLoad()
        profileImageView.image = nil
    }
}

//MARK: - Bind Methods
private extension ReviewListTableViewCell {
    func bindImage() {
        viewModel?.image.bind { [weak self] profile in
            DispatchQueue.main.async {
                self?.profileImageView.image = profile
            }
        }
    }
}

//MARK: - View Configure
private extension ReviewListTableViewCell {
    func setupLayout() {
        [
            profileImageView,
            nameLabel,
            rateLabel,
            contentLabel,
            dateLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let commonSpacing = 16.0
        let safeArea = contentView.safeAreaLayoutGuide
        
        nameLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .vertical)
        rateLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .vertical)
        contentLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .vertical)
        dateLabel.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
        
        NSLayoutConstraint.activate([
            profileImageView
                .widthAnchor
                .constraint(equalToConstant: 70.0),
            profileImageView
                .heightAnchor
                .constraint(equalToConstant: 70.0),
            profileImageView
                .leadingAnchor
                .constraint(equalTo: safeArea.leadingAnchor, constant: commonSpacing),
            profileImageView
                .topAnchor
                .constraint(equalTo: safeArea.topAnchor, constant: commonSpacing),
            
            nameLabel
                .leadingAnchor
                .constraint(
                    equalTo: profileImageView.trailingAnchor,
                    constant: commonSpacing
                ),
            nameLabel
                .topAnchor
                .constraint(equalTo: safeArea.topAnchor, constant: commonSpacing),
            nameLabel
                .trailingAnchor
                .constraint(equalTo: safeArea.trailingAnchor, constant: -commonSpacing),
            
            rateLabel
                .leadingAnchor
                .constraint(equalTo: nameLabel.leadingAnchor),
            rateLabel
                .topAnchor
                .constraint(equalTo: nameLabel.bottomAnchor, constant: commonSpacing),
            rateLabel
                .trailingAnchor
                .constraint(equalTo: nameLabel.trailingAnchor),
            
            contentLabel
                .leadingAnchor
                .constraint(equalTo: nameLabel.leadingAnchor),
            contentLabel
                .topAnchor
                .constraint(equalTo: rateLabel.bottomAnchor, constant: commonSpacing),
            contentLabel
                .trailingAnchor
                .constraint(equalTo: nameLabel.trailingAnchor),
            
            dateLabel
                .leadingAnchor
                .constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel
                .topAnchor
                .constraint(equalTo: contentLabel.bottomAnchor, constant: commonSpacing),
            dateLabel
                .trailingAnchor
                .constraint(equalTo: nameLabel.trailingAnchor),
            dateLabel
                .bottomAnchor
                .constraint(equalTo: safeArea.bottomAnchor, constant: -commonSpacing)
        ])
    }
}
