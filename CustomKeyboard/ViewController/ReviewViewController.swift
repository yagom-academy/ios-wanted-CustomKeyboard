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
        
        configure()
    }
    
}

extension ReviewViewController {
    private func configure() {
        configureTextView()
        configureDelegate()
        updateHangeulManagerString()
    }
    
    private func configureTextView() {
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        
        textView.isUserInteractionEnabled = false
    }
    
    private func configureDelegate() {
        keyboardView.delegate = self
    }
    
    private func updateHangeulManagerString() {
        textView.text = IOManager.shared.getOutput()
    }
}

extension ReviewViewController: KeyboardViewDelegate {
    func keyboardViewTouch() {
        updateHangeulManagerString()
    }
    
    func keyboardViewReturn() {
        delegate?.reviewViewControllerDismiss(textView.text)
        dismiss(animated: true)
    }
}
