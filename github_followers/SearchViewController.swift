//
//  SearchViewController.swift
//  github_followers
//
//  Created by Jun Lee on 1/28/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let logoImageView = UIImageView()
    let userNameText = GFTextField()
    let searchButton = GFButton(backgroundColor: .systemGreen, title: "Search Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground // set background according to light/dark mode
        configureLogoImageView()
        configureTextField()
        configureSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView) // eq. to adding image view in storyboard. won't show up without this line
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80), // 80 is from trial/error
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userNameText)
        
        NSLayoutConstraint.activate([
            userNameText.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureSearchButton(){
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
