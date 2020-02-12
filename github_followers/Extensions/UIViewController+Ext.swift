//
//  UIViewController+Ext.swift
//  github_followers
//
//  Created by Jun Lee on 2/2/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController{
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async{
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated:  true)
        }
    }
    
    func showEmptyScreen(withMessage message: String, in view: UIView){
        let emptyScreen = GFEmptyStateView(message: message)
        emptyScreen.frame = view.bounds
        view.addSubview(emptyScreen)
    }
    
    func showLoadingScreen(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.3){
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingScreen(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil 
        }
    }
}
