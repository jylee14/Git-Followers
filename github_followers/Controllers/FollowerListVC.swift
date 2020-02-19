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
    } // something that is hashable to pass into diffable data source initializer
    
    var username: String!   // passed in from searchVC
    var collectionView: UICollectionView! // initialized at viewDidLoad, will show data in DDS
    var dataSource: UICollectionViewDiffableDataSource<Section, Followers>!
    
    var page = 1    // use this to query github api
    var hasMoreFollowers = true // set to false so that I dont do unnecessary n/w calls

    var isSearching = false
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
        
        navigationController?.setNavigationBarHidden(false, animated: true) // show the "Followers" title
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground // so that it conforms to light/dark mode
        navigationController?.navigationBar.prefersLargeTitles = true // page title in bold
    }
    
    func configureCollectionView(){
        // initialize the collectionView that will be used throughout this VC
        // set its frame (smallest enclosing rectangle) to be the view's bound (the portion of screen that the VC occupies)
        // and use flow layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        
        view.addSubview(collectionView) // dont forget this step or we wont see anything
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId) // tell VC to use FollowerCell class
        
        collectionView.delegate = self
    }
    
    func configureDataSource(){
        // initialize diffable data source
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView){ collectionView, indexPath, follower in
            // grab a cell (which will be of type FollowerCell.self, having reuseId of FollowerCell.reuseId)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower) // initialize the data inside this cell
            
            return  cell
        }
    }
    
    func configureSearchController(){
        let searchController = UISearchController() // create a search controller
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController  // and simply set navItem.searchController to newly created SC
        searchController.searchBar.placeholder = "Follower Name"
    }
    
    func updateData(using followers: [Followers]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Followers>()
        snapshot.appendSections([.main])    // using section(s)
        snapshot.appendItems(followers)     // append these items
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true) // and let the diffable data source animate & figure out what to keep
        }
    }
    
    func getFollowers(of username: String, page: Int){
        showLoadingScreen() //show this on main before entering bg thread
        NetworkManager.shared.getFollowers(of: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingScreen() //
            
            switch result{ // using Result<Ok, Error> type. same as rust
            case .success(let followers):
                if followers.count < 100{
                    self.hasMoreFollowers = false // this user has no more followers
                }
                self.followers.append(contentsOf: followers) // add to the main DS
                self.updateData(using: self.followers) // tell DDS to update
                
                // if the user turned up no followers, display empty state and return
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
        
        if yOffset >= (contentHeight - screenHeight){        // reached the end
            guard hasMoreFollowers else { return } // no need to make a n/w call if there are no more followers to grab
            page += 1 // inc for api call
            getFollowers(of: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeFollowersList = isSearching ? filteredFollowers : followers
        let selectedFollower = activeFollowersList[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.userName = selectedFollower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        filteredFollowers = followers.filter{ follower in
            follower.login.lowercased().contains(filter.lowercased())
        }
        updateData(using: filteredFollowers)
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(using: followers)
        isSearching = false
    }
}
