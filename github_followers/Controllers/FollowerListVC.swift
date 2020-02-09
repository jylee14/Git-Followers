//
//  FollowerListVC.swift
//  github_followers
//
//  Created by Jun Lee on 1/31/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    enum Section{
        case main
    }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Followers>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func createFlowLayout(columns: CGFloat = 3) -> UICollectionViewFlowLayout{
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
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return  cell
        })
    }
    
    func updateData(followers: [Followers]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(of: username, page: 1) { result in
            switch result{
            case .success(let followers):
                self.updateData(followers: followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Dismiss")
            }
        }
    }
}
