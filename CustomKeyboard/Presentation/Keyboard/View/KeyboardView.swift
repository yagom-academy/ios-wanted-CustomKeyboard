//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by 오국원 on 2022/07/11.
//

import UIKit

class KeyboardView: UIView {
    
    lazy var reviewTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 242/255, green: 243/255, blue: 247/255, alpha: 1)
        label.text = ""
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var collectionView: UICollectionView = {
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
