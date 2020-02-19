//
//  GFAlertVC.swift
//  github_followers
//
//  Created by Jun Lee on 2/2/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView = GFAlertView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let errorMessage = GFBodyLabel(textAlignment: .center)
    let dismissButton = GFButton(backgroundColor: .systemPink, title: "Dismiss")
    
    let padding: CGFloat = 20.0
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        
        // ordered title - button - body so that body can fill in the remaining view (top/bot anchor to title/button)
        configureTitleLabel()
        configureButton()
        configureBodyLabel()
    }
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Encountered an Error!"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureBodyLabel(){
        containerView.addSubview(errorMessage)
        errorMessage.text = self.message ?? "Unable to complete request"
        errorMessage.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            errorMessage.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -8),
            errorMessage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            errorMessage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureButton(){
        containerView.addSubview(dismissButton)
        dismissButton.setTitle(buttonTitle ?? "Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            dismissButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    @objc private func dismissButtonVC(){
        dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
