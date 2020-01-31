//
//  GFTextField.swift
//  github_followers
//
//  Created by Jun Lee on 1/30/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label // does system coloring for color mode automatically
        tintColor = .label // want it to mirror text color
        textAlignment = .center
        
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true // automatically change font size if text gets too long
        minimumFontSize = 12 // dont want the font to be too small
        
        backgroundColor = .tertiarySystemBackground // light but not blending in
        autocorrectionType = .no // username dont need it
        
        placeholder = "Enter a username"
    }
}
