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
        label.layer.cornerRadius = 30
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.systemCyan.cgColor
        label.text = ""
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
        collectionView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
//    init(image : UIImage, frame : CGRect) { // custom initialize
//        super.init(frame: frame)
//    }
    
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
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
