//
//  SeochoKeyboardViewController.swift
//  SeochoKeyboard
//
//  Created by 조성빈 on 2022/07/20.
//

import UIKit
import Combine

class SeochoKeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    private let keyboardView = KeyboardView()
    
    var keyboardViewModel = KeyboardViewModel()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    var disposalbleBag = Set<AnyCancellable>()

    var isShift : Int = 0
    var buffer : [String] = []
    var count : Int = 0
        
    override func loadView() {
        super.loadView()
        self.view = keyboardView
        keyboardView.collectionView.dataSource = self
        keyboardView.collectionView.delegate = self
        setBindings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

extension SeochoKeyboardViewController {
    func setBindings() {
        self.keyboardViewModel.$buffer.sink { updatedBuffer in
            self.buffer = updatedBuffer
        }.store(in: &disposalbleBag)
        
        self.keyboardViewModel.$isShift.sink { updatedShift in
            self.isShift = updatedShift
            DispatchQueue.main.async {
                self.keyboardView.collectionView.reloadData()
            }
        }.store(in: &disposalbleBag)
        
        self.keyboardViewModel.$count.sink { updatedCount in
            self.count = updatedCount
        }.store(in: &disposalbleBag)
    }
}

extension SeochoKeyboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboadCollectionViewCell.identifier, for: indexPath) as? KeyboadCollectionViewCell else { return UICollectionViewCell() }
        if isShift == 0 {
            cell.letter.text = keyboardViewModel.consonant[indexPath.row]
        } else {
            cell.letter.text = keyboardViewModel.doubleConsonant[indexPath.row]
        }
        return cell
    }
}

extension SeochoKeyboardViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //cell의 크기를 지정해주는 함수 sizeForItemAt
        return CGSize(width: 35, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {// 옆 간격을 지정해 줄 수 있는 함수 minimumInteritemSpacingForSectionAt
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 위 아래 세로 간격을 지정해주는
        return 6
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        
        //Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(2/5)
            ),
            subitem: item,
            count: 2
        )
        //Sections
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension SeochoKeyboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        keyboardViewModel.processKeyboardInput(indexPath.row)
        while textDocumentProxy.hasText {
            textDocumentProxy.deleteBackward()
        }
        textDocumentProxy.insertText(keyboardViewModel.automata().joined(separator: "")) // convert array to string
    }
}
