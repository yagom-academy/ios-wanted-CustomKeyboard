//
//  ReviewTableViewCell.swift
//  CustomKeyboard
//
//  Created by 이윤주 on 2022/07/12.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {

    // MARK: - Type property

    static let identifier = String(describing: ReviewTableViewCell.self)

    // MARK: - UIProperties

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.tintColor = .systemGray4
        imageView.image = Style.profileImage
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var reviewVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Style.spacing
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = Text.userName
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = Style.oneLine
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.text = Text.review
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = .zero
        return label
    }()

    private lazy var uploadedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = Text.uploadedTime
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .tertiaryLabel
        return label
    }()

    // MARK: - Lifecycles

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellStyle()
        setupView()
        setupConstraints()
    }

    @available(*, unavailable, message: "This initializer is not available.")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCellStyle()
        setupView()
        setupConstraints()
    }
    
    override func draw(_ rect: CGRect) {
        profileImageView.layer.cornerRadius = profileImageView.frame.width * Style.half
    }
    
    override func prepareForReuse() {
        profileImageView.image = Style.profileImage
    }

}

extension ReviewTableViewCell {
    
    func setupCell(review: ReviewResult) {
        nameLabel.text = review.user.userName
        reviewLabel.text = review.content
        uploadedTimeLabel.text = review.toElapsedTime()
    }
    
    func setupProfileImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.profileImageView.image = image
        }
    }
    
}

// MARK: - View setting methods

extension ReviewTableViewCell {
    
    private func setupCellStyle() {
        self.selectionStyle = .none
    }

    private func setupView() {
        [profileImageView,
         reviewVerticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }

        [nameLabel,
         reviewLabel,
         uploadedTimeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            reviewVerticalStackView.addArrangedSubview($0)
        }
    }

    private func setupConstraints() {
        setupConstraintsOfProfileImageView()
        setupConstraintsOfTextVerticalStackView()
    }

    private func setupConstraintsOfProfileImageView() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Style.padding
            ),
            profileImageView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: Style.padding
            ),
            profileImageView.widthAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.widthAnchor,
                multiplier: Style.widthRatio
            ),
            profileImageView.heightAnchor.constraint(
                equalTo: profileImageView.safeAreaLayoutGuide.widthAnchor
            )
        ])
    }

    private func setupConstraintsOfTextVerticalStackView() {
        NSLayoutConstraint.activate([
            reviewVerticalStackView.leadingAnchor.constraint(
                equalTo: profileImageView.safeAreaLayoutGuide.trailingAnchor,
                constant: Style.padding
            ),
            reviewVerticalStackView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Style.padding
            ),
            reviewVerticalStackView.topAnchor.constraint(
                equalTo: profileImageView.safeAreaLayoutGuide.topAnchor
            ),
            reviewVerticalStackView.centerYAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerYAnchor
            )
        ])
    }

}

// MARK: - NameSpaces

extension ReviewTableViewCell {

    private enum Text {
        static let userName: String = "o달빔o"
        static let review: String = "리뷰: 아진짜 귀여워요!!!!"
        static let uploadedTime: String = "1분"
    }

    private enum Style {
        static let oneLine: Int = 1
        static let profileImage: UIImage? = UIImage(systemName: "person.fill")
        static let spacing: CGFloat = 10
        static let padding: CGFloat = 15
        static let widthRatio: CGFloat = 0.15
        static let half: CGFloat = 0.5
    }

}
