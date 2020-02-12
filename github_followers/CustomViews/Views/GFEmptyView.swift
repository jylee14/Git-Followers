//
//  GFEmptyState.swift
//  github_followers
//
//  Created by Jun Lee on 2/11/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    var logoImageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureView()
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configureView()
    }
    
    private func configureView(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 2
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9), //make the image's width = 1.3x screen width
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 150),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 180)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
