//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/13.
//

import UIKit

final class ReviewListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = ReviewListViewModel()
    private var collectionView: UICollectionView!
    private let reviewTextFieldStack = UIStackView()
    private let profileImageView = UIImageView()
    private let reviewTextView = UITextView()
    private var reviewPostButton = UIButton()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureUI()
        addTapGesture()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods
extension ReviewListViewController {
    private func fetchData() {
        
        viewModel.fetchData { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func postData() {
        
        viewModel.postData(text: reviewTextView.text) { result in
            switch result {
            case .success(let result):
                self.addSuccessAlert(statusCode: result)
            case .failure(let customError):
                self.addFailureAlert(error: customError.description)
            }
        }
    }
    
    private func addTapGesture() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.reviewTextView.addGestureRecognizer(tapGestureRecognizer)
    }
    //TODO: String값 따로 보관하도록하는게 좋다
    private func addSuccessAlert(statusCode: NetworkManager.ResponseCode) {
        
        let postAlert = UIAlertController(title: "알림", message: "Status Code: \(statusCode)\n 리뷰 작성이 성공했습니다.", preferredStyle: .alert)
        postAlert.addAction(UIAlertAction(title: "닫기", style: .destructive))
        self.present(postAlert, animated: true)
    }
    
    private func addFailureAlert(error: String) {
        
        let postAlert = UIAlertController(title: "경고", message: "에러 원인: \(error)\n 리뷰 작성이 실패했습니다.", preferredStyle: .alert)
        postAlert.addAction(UIAlertAction(title: "닫기", style: .destructive))
        self.present(postAlert, animated: true)
    }
    
}

// MARK: - @objc Methods
extension ReviewListViewController {
    @objc func didTapView() {
        
        let viewController = ReviewWriteViewController(inputField: reviewTextView)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func didTapWriteButton() {
        
        postData()
    }
}

// MARK: - ConfigureUI
extension ReviewListViewController {
    private func configureUI() {
        
        view.backgroundColor = .systemBackground
        title = "CustomKeyboard"
        configureAttribute()
        configureStackView()
        configureCollectionViewLayout()
    }
    
    private func configureAttribute() {
        
        //스택뷰
        reviewTextFieldStack.axis = .horizontal
        reviewTextFieldStack.spacing = 10
        reviewTextFieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        //프로필이미지뷰
        let imageIcon = UIImage(systemName: "person.crop.circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        profileImageView.image = imageIcon
        
        //텍스트뷰
        reviewTextView.text = "이 테마가 마음에 드시나요?"
        reviewTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        reviewTextView.font = .boldSystemFont(ofSize: 16)
        reviewTextView.layer.cornerRadius = 15
        reviewTextView.backgroundColor = .systemGray6
        
        //작성버튼
        reviewPostButton = UIButton(type: .system)
        reviewPostButton.backgroundColor = .systemBlue
        reviewPostButton.layer.cornerRadius = 10
        reviewPostButton.setTitle("작성", for: .normal)
        reviewPostButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        reviewPostButton.setTitleColor(.white, for: .normal)
        reviewPostButton.addTarget(self, action: #selector(didTapWriteButton) , for: .touchUpInside)
        
    }
    
    private func configureStackView() {
        
        view.addSubview(reviewTextFieldStack)
        NSLayoutConstraint.activate([
            reviewTextFieldStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            reviewTextFieldStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewTextFieldStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewTextFieldStack.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
        
        reviewTextFieldStack.addArrangedSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
        ])
        
        reviewTextFieldStack.addArrangedSubview(reviewTextView)
        reviewTextFieldStack.addArrangedSubview(reviewPostButton)
        NSLayoutConstraint.activate([
            reviewPostButton.widthAnchor.constraint(equalTo: reviewTextFieldStack.widthAnchor, multiplier: 0.15),
        ])
    }
    
    private func configureCollectionViewLayout() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ReviewListCell.self, forCellWithReuseIdentifier: ReviewListCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: reviewTextFieldStack.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //아이템
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
        
        //그룹
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/3)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item, count: 1
        )
        
        //섹션
        let section = NSCollectionLayoutSection(group: group)
        
        //레이아웃
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

// MARK: - CollectionView DataSource
extension ReviewListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.reviewDataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewListCell.reuseIdentifier, for: indexPath) as? ReviewListCell else {
            return ReviewListCell()
        }
        
        cell.configure(data: viewModel.reviewData(indexPath: indexPath))
        
        return cell
    }
    
}
