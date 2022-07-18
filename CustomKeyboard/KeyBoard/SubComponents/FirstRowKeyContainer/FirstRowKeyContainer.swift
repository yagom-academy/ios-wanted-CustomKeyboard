//
//  FirstRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

class FirstRowKeyContainer: UIStackView {
    private let firstLineDynamicBasicKeys = DynamicBasicKeyLine()
    weak var delegate: FirstRowKeyContainerDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
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

extension FirstRowKeyContainer {
    func toggleDynamicBasicKeyState() {
        firstLineDynamicBasicKeys.toggleDynamicBasicKeyState()
    }
    
    private func attribute() {
        firstLineDynamicBasicKeys.delegate = self
        
        self.axis = .horizontal
    }
    
    private func layout() {
        self.addArrangedSubview(firstLineDynamicBasicKeys)
        firstLineDynamicBasicKeys.translatesAutoresizingMaskIntoConstraints = false
    }
}
