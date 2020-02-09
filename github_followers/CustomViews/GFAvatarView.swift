//
//  GFAvatarView.swift
//  github_followers
//
//  Created by Jun Lee on 2/9/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFAvatarView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true // sets the image to conform to the corner radius
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
