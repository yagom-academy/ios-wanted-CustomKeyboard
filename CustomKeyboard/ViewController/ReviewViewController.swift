//
//  ReviewViewController.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/14.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var keyboardView: KeyboardView_sungeo!
    
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
        //
    }
}
