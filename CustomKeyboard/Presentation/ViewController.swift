//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class ViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchReview { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(_):
                print(CustomError.loadError)
            }
        }
        
    }
}

