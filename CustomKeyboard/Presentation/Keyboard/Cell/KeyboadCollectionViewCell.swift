//
//  KeyboadCollectionViewCell.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
//

import UIKit

final class KeyboadCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "KeyboadCollectionViewCell"
    
    var letter: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        self.layer.cornerRadius = 10
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(letter)
        letter.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            letter.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            letter.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
