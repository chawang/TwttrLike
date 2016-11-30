//
//  Extensions.swift
//  TwttrLike
//
//  Created by Charles Wang on 11/27/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func timeSince() -> String {
        let interval = -1 * self.timeIntervalSinceNow
        let mins = interval / 60
        let hours = interval / 3600
        let days = interval / (3600 * 24)
        
        if interval < 60 {
            return "\(Int(interval)) s"
        } else if mins < 60 {
            return "\(Int(mins)) m"
        } else if hours < 24 {
            return "\(Int(hours)) hr"
        } else if days < 7 {
            return "\(Int(days)) d"
        } else {
            return "wk+"
        }
    }
    func simpleDateTime() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d/yy, HH:mm"
        return formatter.string(from: self)
    }
}
