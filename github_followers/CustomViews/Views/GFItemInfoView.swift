//
//  GFItemInfoView.swift
//  github_followers
//
//  Created by Jun Lee on 2/22/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

enum ItemInfoType{
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    var sfSymbol = UIImageView()
    var titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    var countLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    func set(_ itemInfo: ItemInfoType, withCount count: Int){
        switch itemInfo{
        case .repos:
            sfSymbol.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            sfSymbol.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            sfSymbol.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            sfSymbol.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
    private func configure(){
        addSubview(sfSymbol)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        sfSymbol.translatesAutoresizingMaskIntoConstraints = false
        sfSymbol.contentMode = .scaleAspectFill
        sfSymbol.tintColor = .label
        
        NSLayoutConstraint.activate([
            sfSymbol.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sfSymbol.topAnchor.constraint(equalTo: self.topAnchor),
            sfSymbol.widthAnchor.constraint(equalToConstant: 20),
            sfSymbol.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: sfSymbol.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: sfSymbol.trailingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            countLabel.leadingAnchor.constraint(equalTo: sfSymbol.trailingAnchor, constant: 12),
            countLabel.topAnchor.constraint(equalTo: sfSymbol.bottomAnchor, constant: 4),
            countLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
