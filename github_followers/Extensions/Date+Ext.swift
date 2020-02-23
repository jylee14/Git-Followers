//
//  Date+Ext.swift
//  github_followers
//
//  Created by Jun Lee on 2/22/20.
//  Copyright © 2020 Jun Lee. All rights reserved.
//

import Foundation

extension Date{
    func fromUtcDateToMonYear() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = .current
        
        return dateFormatter.string(from: self) 
    }
}
