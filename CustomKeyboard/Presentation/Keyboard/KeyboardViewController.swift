//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/12.
//

import UIKit

class KeyboardViewController: UIViewController {

    var keyboardView: KeyboardView!
    
    override func loadView() {
        super.loadView()
        keyboardView = .init(frame: self.view.frame)
        keyboardView.delegate = self
        self.view = keyboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension KeyboardViewController: KeyboardViewDismissible {
    
    func dismissKeyboardViewController(reviewContents: String) {
        NotificationCenter.default.post(
            name: .sendKeyboardContentsToReviewWrittingLabel,
            object: nil,
            userInfo: ["reviewContents": reviewContents]
        )
        self.dismiss(animated: true)
    }

}
