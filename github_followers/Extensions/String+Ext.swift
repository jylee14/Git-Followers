//
//  String+Ext.swift
//  github_followers
//
//  Created by Jun Lee on 2/22/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

extension String{
    func parseUtcDateString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
}
