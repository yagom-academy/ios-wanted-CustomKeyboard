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
        return image
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var reviewTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
    }
    
}
