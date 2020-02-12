//
//  GFAlertView.swift
//  github_followers
//
//  Created by Jun Lee on 2/6/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFAlertView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(){
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
