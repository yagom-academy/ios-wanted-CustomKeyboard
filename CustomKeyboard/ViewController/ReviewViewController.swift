//
//  ReviewViewController.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/14.
//

import UIKit

protocol ReviewViewControllerDelegate: AnyObject {
    func reviewViewControllerDismiss(_ text: String)
}

class ReviewViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var keyboardView: KeyboardView_sungeo!
    
    weak var delegate: ReviewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardView.delegate = self
    }
    
}

extension ReviewViewController: KeyboardViewDelegate {
    func keyboardViewTouch() {
        textView.text = HangeulManager.shared.getOutputString()
    }
    
    func keyboardViewReturn() {
        delegate?.reviewViewControllerDismiss(textView.text)
        dismiss(animated: true)
    }
}
