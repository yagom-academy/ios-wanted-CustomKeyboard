//
//  ViewController.swift
//  CustomKeyboard
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetchReview() {
        let url = URL(string: "https://api.plkey.app/theme/review")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print(URLError.badServerResponse)
                return
            }
            
            let data = try JSONDecoder().decode(from: data)
        }
    }
}

