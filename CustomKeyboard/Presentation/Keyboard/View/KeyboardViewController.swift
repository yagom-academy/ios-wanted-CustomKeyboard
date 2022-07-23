//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 서초 on 2022/07/11.
//

import UIKit
import Combine

protocol KeyboardViewControllerDelegate : AnyObject {
    func updateLabelText(_ reviewText : String?)
}

class KeyboardViewController: BaseViewController {
    
    private let keyboardView = KeyboardView()
    var keyboardViewModel = KeyboardViewModel()
    var koreanAutomata = KoreanAutomata()
    var disposalbleBag = Set<AnyCancellable>()
    weak var delegate : KeyboardViewControllerDelegate?

    var onShift : Int = 0
    var buffer : [String] = []
    var count : Int = 0

    override func loadView() {
        super.loadView()
        self.view = keyboardView
        keyboardView.collectionView.dataSource = self
        keyboardView.collectionView.delegate = self
        setBindings()
    }
    
    deinit {
        print("deinit")
    }
}

extension KeyboardViewController {
    func setBindings() {
        self.keyboardViewModel.$buffer.sink {[weak self] updatedBuffer in
            self?.buffer = updatedBuffer
        }.store(in: &disposalbleBag)
        
        self.keyboardViewModel.$onShift.sink {[weak self] updatedShift in
            self?.onShift = updatedShift
            DispatchQueue.main.async {
                self?.keyboardView.collectionView.reloadData()
            }
        }.store(in: &disposalbleBag)
        
        self.keyboardViewModel.$count.sink {[weak self] updatedCount in
            self?.count = updatedCount
        }.store(in: &disposalbleBag)
    }
}

extension KeyboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboadCollectionViewCell.identifier, for: indexPath) as? KeyboadCollectionViewCell else { return UICollectionViewCell() }
        if onShift == 0 {
            cell.letter.text = keyboardViewModel.keyboardLayout[indexPath.row]
        } else {
            cell.letter.text = keyboardViewModel.keyboardLayoutWithShift[indexPath.row]
        }
        return cell
    }
}

extension KeyboardViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if keyboardViewModel.keyboardLayout[indexPath.row] == "Shift" || keyboardViewModel.keyboardLayout[indexPath.row] == "Del" {
            return CGSize(width: self.view.bounds.width / 8.5, height: 40)
        } else if keyboardViewModel.keyboardLayout[indexPath.row] == "Space" {
            return CGSize(width: self.view.bounds.width * 3.6 / 5, height: 40)
        } else if keyboardViewModel.keyboardLayout[indexPath.row] == "Return" {
            return CGSize(width: self.view.bounds.width * 1.1 / 5, height: 40)
        } else {
            return CGSize(width: self.view.bounds.width / 11, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(2/5)
            ),
            subitem: item,
            count: 3
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension KeyboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if keyboardViewModel.keyboardLayout[indexPath.row] == "Return" || keyboardViewModel.keyboardLayoutWithShift[indexPath.row] == "Return" {
            pressEnter()
        }
        keyboardViewModel.handleKeyboardInput(indexPath.row)
        keyboardViewModel.automata()
        keyboardView.reviewTextLabel.text = KoreanAutomata.AutomataInfo.finalArray.joined(separator: "")
    }
    
    func pressEnter() {
        delegate?.updateLabelText(keyboardView.reviewTextLabel.text)
        self.dismiss(animated: true)
    }
}
