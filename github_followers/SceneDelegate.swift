//
//  SceneDelegate.swift
//  github_followers
//
//  Created by Jun Lee on 1/28/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds) // fill up the full screen
        window?.windowScene = windowScene
        window?.rootViewController = initializeTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func createSearchNC() -> UINavigationController{
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController{
        let favoriteVC = FavoritesViewController()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    func initializeTabBarController() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        
        tabBar.viewControllers = [createSearchNC(), createFavoritesNC()]
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

