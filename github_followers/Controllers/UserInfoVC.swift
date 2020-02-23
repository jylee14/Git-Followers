//
//  UserInfoVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/18/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

protocol UserInfoVcDelegate: class{
    func didTapGithubRepoButton(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    var userName: String!
    
    let containerView = UIView()
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    weak var delegate: FollowerListVCDelegate!
    
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
                DispatchQueue.main.async { self.configureUI(with: user)}
            }
        }
    }
    
    private func configureUI(with user: User){
        let repoVc = GFRepoItemVC(user: user)
        repoVc.delegate = self
        
        let followerVc = GFFollowersItemVC(user: user)
        followerVc.delegate = self
        
        add(childVC: GFUserInfoHeaderVC(user: user), to: headerView)
        add(childVC: repoVc, to: itemView1)
        add(childVC: followerVc, to: itemView2)
        
        let userSince = user.createdAt.parseUtcDateString()?.fromUtcDateToMonYear() ?? "forever :)"
        dateLabel.text = "Github user since: \(userSince)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func layoutUI(_ children: [UIView]){
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
    
    private func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVcDelegate{
    func didTapGithubRepoButton(for user: User){
        // show safari page that goes to "https://github.com/\(username)"
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Uh-oh", message: "Couldn't open github page for this user", buttonTitle: "Dismiss")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        // dismiss current userInfoVC and reload followersListVC with a new network call
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Uh-oh", message: "This user has no followers!", buttonTitle: "Dismiss")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
