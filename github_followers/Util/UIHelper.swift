//
//  UIHelper.swift
//  github_followers
//
//  Created by Jun Lee on 2/9/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

struct UIHelper{
    static func createFlowLayout(in view: UIView, withColumns columns: CGFloat = 3) -> UICollectionViewFlowLayout{
        let width = view.bounds.width //total width of the device screen
        let padding: CGFloat = 12
        let minItemSpace: CGFloat = 10
        let availableWidth = width - (2 * padding) - ((columns - 1) * minItemSpace)
        let cellWidth = availableWidth / columns
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 35) // to account for the GFLabel under the avatar
        
        return layout
    }
}
