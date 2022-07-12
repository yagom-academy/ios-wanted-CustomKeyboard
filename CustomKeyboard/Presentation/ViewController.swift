//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class ViewController: UIViewController {
    

    init() {
        super.init(nibName: nil, bundle: nil)
        testCustomKeyBoard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - 커스텀키보드 테스트용
extension ViewController {
    private func testCustomKeyBoard() {
        let customKeyboard = CustomKeyBoard()
        self.view.addSubview(customKeyboard)
        
        customKeyboard.translatesAutoresizingMaskIntoConstraints = false
        customKeyboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        customKeyboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        customKeyboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        customKeyboard.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
