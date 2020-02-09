//
//  FollowerListVC.swift
//  github_followers
//
//  Created by Jun Lee on 1/31/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(of: username, page: 1) { result in
            switch result{
            case .success(let followers):
                print("followers: \(followers.count)")
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Dismiss")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
