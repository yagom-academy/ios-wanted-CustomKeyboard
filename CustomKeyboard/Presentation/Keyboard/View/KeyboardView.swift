//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
//

import UIKit

class KeyboardView: UIView {
        
    let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = ""
        label.textColor = .darkGray
        label.sizeToFit()
        label.numberOfLines = 10
        return label
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let collectionView: UICollectionView = {
        lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(KeyboadCollectionViewCell.self, forCellWithReuseIdentifier: KeyboadCollectionViewCell.identifier)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)
        
        [reviewTextLabel, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            reviewTextLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            reviewTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant: 20),
            verticalStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.bottomAnchor,constant: -200),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
