//
//  GFRepoItemVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/22/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC{
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems(){
        itemInfoLeft.set(.repos, withCount: user.publicRepos)
        itemInfoRight.set(.gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
