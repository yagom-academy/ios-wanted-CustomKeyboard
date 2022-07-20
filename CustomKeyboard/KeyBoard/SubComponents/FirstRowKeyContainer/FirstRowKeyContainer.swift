//
//  FirstRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

class FirstRowKeyContainer: UIStackView {
    
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

extension FirstRowKeyContainer: BasicKeyLineDelegate {
    func tappedBasicKeyButton(unicode: Int) {
        delegate?.tappedFirstrowBasicKey(unicode: unicode)
    }
}

// MARK: - Methods
extension FirstRowKeyContainer {
    func toggleDynamicBasicKeyState() -> DynamicBasicKeyLine.State {
        return firstLineDynamicBasicKeys.toggleDynamicBasicKeyState()
    }
}

// MARK: - ConfigureUI
extension FirstRowKeyContainer {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        firstLineDynamicBasicKeys.delegate = self
        self.axis = .horizontal
    }
    
    private func configureLayout() {
        
        self.addArrangedSubview(firstLineDynamicBasicKeys)
        firstLineDynamicBasicKeys.translatesAutoresizingMaskIntoConstraints = false
    }
}
