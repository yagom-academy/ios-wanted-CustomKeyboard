//
//  ReviewListTableViewCell.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

final class ReviewListTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewListTableViewCell"
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return image
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "o달빔o"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor(red: 66/255, green: 68/255, blue: 75/255, alpha: 1)
        return label
    }()
    
    lazy var reviewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "별점: @@@@@\n리뷰: 아진짜 귀여워요!!!"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 81/255, green: 83/255, blue: 91/255, alpha: 1)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1분"
        label.textColor = UIColor(red: 145/255, green: 146/255, blue: 152/255, alpha: 1)
        return label
    }()
    
    var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    
    var verticcalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalStackView)
        
        [profileImage,verticcalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.addArrangedSubview($0)
        }
        
        [userNameLabel,reviewTextLabel,timeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            verticcalStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
