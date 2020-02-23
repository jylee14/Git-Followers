//
//  UserInfoVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/18/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    var userName: String!
    
    let containerView = UIView()
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        getUserInfo()
        
        let childViews = [headerView, itemView1, itemView2, dateLabel]
        layoutUI(childViews)
    }
    
    private func configure(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserInfo(){
        NetworkManager.shared.getSingleUserInfo(userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Dismiss")
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemView1)
                    self.add(childVC: GFFollowersItemVC(user:user), to:self.itemView2)
                    
                    let userSince = user.createdAt.parseUtcDateString()?.fromUtcDateToMonYear() ?? "forever :)"
                    self.dateLabel.text = "Github user since: \(userSince)"
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func layoutUI(_ children: [UIView]){
        let padding: CGFloat = 20
        
        for idx in 0 ..< children.count{
            let currentChild = children[idx]
            view.addSubview(currentChild)
            currentChild.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                currentChild.topAnchor.constraint(equalTo: idx == 0 ? view.safeAreaLayoutGuide.topAnchor : children[idx - 1].bottomAnchor, constant: padding),
                currentChild.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                currentChild.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 180),
            itemView1.heightAnchor.constraint(equalToConstant: 140),
            itemView2.heightAnchor.constraint(equalToConstant: 140),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
