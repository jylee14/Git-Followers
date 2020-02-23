//
//  GFItemInfoVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/22/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
    let itemContainer   = UIStackView()
    let itemInfoLeft    = GFItemInfoView(frame: .zero)
    let itemInfoRight   = GFItemInfoView(frame: .zero)
    let actionButton    = GFButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerCard()
        configureContainer()
        layoutUI()
    }

    private func configureContainerCard(){
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 14
    }
    
    private func configureContainer(){
        itemContainer.addArrangedSubview(itemInfoLeft)
        itemContainer.addArrangedSubview(itemInfoRight)
        itemContainer.axis = .horizontal
        itemContainer.distribution = .fillEqually
    }
    
    private func layoutUI(){
        itemContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemContainer)
        view.addSubview(actionButton)
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            itemContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            itemContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            itemContainer.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.heightAnchor.constraint(equalToConstant: 45),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}
