//
//  UserInfoVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/18/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.getSingleUserInfo(userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Dismiss")
            case .success(let user):
                print(user)
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
