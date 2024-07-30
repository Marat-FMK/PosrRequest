//
//  ViewController.swift
//  PosrRequest
//
//  Created by Marat Fakhrizhanov on 30.07.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlLabel.text = Link.urlForRequest.rawValue
        
    }


    
    @IBAction func fetchData() {
        let man = Man(name: "Piter", surname: "Pen", age: "17")
        
        NetworkManager.shared.fetchData(with: man, to: Link.urlForRequest.rawValue) { result in
            switch result {
                
            case .success(let postMan):
                DispatchQueue.main.async {
                    self.userInfoLabel.text = "ok"
                    self.urlLabel.text = postMan.name
                    print(postMan)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

