//
//  FavoritesViewController.swift
//  github_followers
//
//  Created by Jun Lee on 1/28/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    let tableView = UITableView()
    var favorites = [Followers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func configure(){
        view.backgroundColor = .systemBackground
        self.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseId)
    }
    
    private func getFavorites(){
        PersistenceManager.retrieveFavorites {[weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyScreen(withMessage: "You have no favorites!", in: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Uh-Oh", message: error.rawValue, buttonTitle: "Dismiss")
            }
        }
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource{
    // Q: how many rows will there be for this section?
    // A: however many items are in favorites view. this will only have 1 section that contains all the favorites
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseId) as! FavoritesCell
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = selectedCell.login
        destVC.title = selectedCell.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let selected = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        PersistenceManager.updateFavoritesListWith(selected, method: .remove){ [weak self] error in
            guard let self = self else { return }
            if error != nil{
                self.presentGFAlertOnMainThread(title: "Uh-oh", message: error!.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
