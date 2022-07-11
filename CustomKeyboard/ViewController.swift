//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class ViewController: UIViewController {

    var networkManager: NetworkManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        networkManager?.fetchAllReviews(completion: { result in
            print(result)
        })
    }
}

