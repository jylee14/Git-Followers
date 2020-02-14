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
    
    var page = 1
    var hasMoreFollowers = true

    var followers: [Followers] = []
    var filteredFollowers: [Followers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        getFollowers(of: username, page: page)
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        
        collectionView.delegate = self
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return  cell
        })
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Follower Name"
        
        navigationItem.searchController = searchController
    }
    
    func updateData(using followers: [Followers]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func getFollowers(of username: String, page: Int){
        showLoadingScreen()
        NetworkManager.shared.getFollowers(of: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingScreen()
            
            switch result{
            case .success(let followers):
                if followers.count < 100{
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                self.updateData(using: self.followers)
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyScreen(withMessage: "This user has no followers. Go follow them!", in: self.view)
                    }
                    return
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Dismiss")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let yOffset = scrollView.contentOffset.y            // how far the user has scrolled through the list
        let contentHeight = scrollView.contentSize.height   // total height (if all the cells were laid top to bottom)
        let screenHeight = scrollView.frame.height          // screen height of the UICollectionView
        
        if yOffset > (contentHeight - screenHeight){        // reached the end
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(of: username, page: page)
        }
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        filteredFollowers = followers.filter{ follower in
            follower.login.lowercased().contains(filter.lowercased())
        }
        updateData(using: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(using: followers)
    }
}
