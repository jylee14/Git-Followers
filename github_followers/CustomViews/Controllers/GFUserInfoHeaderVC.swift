//
//  GFUserInfoHeaderVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/19/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    let avatarView  = GFAvatarView(frame: .zero)
    let loginName   = GFTitleLabel(textAlignment: .left, fontSize: 36)
    let bioName     = GFSecondaryTitleLabel(size: 18)
    let locationImg = UIImageView()
    let location    = GFSecondaryTitleLabel(size: 18)
    let bioLabel    = GFBodyLabel(textAlignment: .left)
    
    var user: User!

    init(user: User){
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        layoutUIConstraints()
        configureUIElements()
    }
    
    func configureUIElements(){
        avatarView.downloadImage(from: user.avatarUrl) //download and set image to avatar
        loginName.text  = user.login
        bioName.text    = user.name ?? ""
        location.text   = user.location ?? "No location"
        bioLabel.text   = user.bio ?? ""
        bioLabel.numberOfLines = 3
        
        locationImg.image       = UIImage(systemName: SFSymbols.location)
        locationImg.tintColor   = .secondaryLabel
    }
    
    func addSubViews(){
        view.addSubview(avatarView)
        view.addSubview(loginName)
        view.addSubview(bioName)
        view.addSubview(locationImg)
        view.addSubview(location)
        view.addSubview(bioLabel)
    }
    
    func layoutUIConstraints(){
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        locationImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 90),
            avatarView.widthAnchor.constraint(equalToConstant: 90),
            
            loginName.topAnchor.constraint(equalTo: view.topAnchor),
            loginName.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: textImagePadding),
            loginName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginName.heightAnchor.constraint(equalToConstant: 38),
            
            bioName.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor, constant: 8),
            bioName.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: textImagePadding),
            bioName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioName.heightAnchor.constraint(equalToConstant: 20),
            
            locationImg.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            locationImg.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: textImagePadding),
            locationImg.heightAnchor.constraint(equalToConstant: 20),
            locationImg.widthAnchor.constraint(equalToConstant: 20),
            
            location.leadingAnchor.constraint(equalTo: locationImg.trailingAnchor, constant: 5),
            location.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            location.centerYAnchor.constraint(equalTo: locationImg.centerYAnchor),
            location.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
