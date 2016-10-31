//
//  User.swift
//  TwttrLike
//
//  Created by Charles Wang on 10/30/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileURL: URL?
    
    init(dictionary:NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileURLstring = dictionary["profile_image_url_https"] as? String
        if let profileURLstring = profileURLstring{
            profileURL = URL(string: profileURLstring)
        }
    }
}
