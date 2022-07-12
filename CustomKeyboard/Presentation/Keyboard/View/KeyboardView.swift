//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

class KeyboardView: UIView {
    
    lazy var collectionView: UICollectionView = {
        lazy var collectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(KeyboadCollectionViewCell.self, forCellWithReuseIdentifier: KeyboadCollectionViewCell.identifier)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.bottomAnchor,constant: -200),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
