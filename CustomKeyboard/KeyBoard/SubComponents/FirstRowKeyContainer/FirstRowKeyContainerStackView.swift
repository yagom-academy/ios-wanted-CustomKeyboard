//
//  FirstRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

final class FirstRowKeyContainerStackView: UIStackView {
    
    // MARK: - Properties
    private let firstLineDynamicBasicKeys = DynamicBasicKeyLine()
    weak var delegate: FirstRowKeyContainerDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirstRowKeyContainerStackView: BasicKeyLineDelegate {
    func tappedBasicKeyButton(unicode: Int) {
        delegate?.tappedFirstrowBasicKey(unicode: unicode)
    }
}

// MARK: - Methods
extension FirstRowKeyContainerStackView {
    func toggleDynamicBasicKeyState() -> DynamicBasicKeyLine.State {
        return firstLineDynamicBasicKeys.toggleDynamicBasicKeyState()
    }
}

// MARK: - ConfigureUI
extension FirstRowKeyContainerStackView {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        axis = .horizontal
        firstLineDynamicBasicKeys.delegate = self
    }
    
    private func configureLayout() {
        
        addArrangedSubview(firstLineDynamicBasicKeys)
        firstLineDynamicBasicKeys.translatesAutoresizingMaskIntoConstraints = false
    }
}
