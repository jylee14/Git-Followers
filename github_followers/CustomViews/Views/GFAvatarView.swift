//
//  GFAvatarView.swift
//  github_followers
//
//  Created by Jun Lee on 2/9/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import UIKit

class GFAvatarView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true // sets the image to conform to the corner radius
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String){
        guard let url = URL(string: urlString) else { return }
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else { return }
                self.image = image
            }
        }else{
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let _ = error { return }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                self.cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            
            task.resume()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
