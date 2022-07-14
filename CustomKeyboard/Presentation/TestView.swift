//
//  TestView.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import UIKit

class TestView: UIViewController {
    let textView = UITextView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        attribute()
        layout()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.textView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView() {
        let vc = ReviewWriteViewController(inputField: textView)
        self.present(vc, animated: true)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        textView.backgroundColor = .gray
    }
    
    private func layout() {
        self.view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
