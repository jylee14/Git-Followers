//
//  UIViewController+Ext.swift
//  github_followers
//
//  Created by Jun Lee on 2/2/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

extension UIViewController{
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async{
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated:  true)
        }
    }
}
