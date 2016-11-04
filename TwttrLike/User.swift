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
    
    var dictionary: NSDictionary?
    
    init(dictionary:NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileURLstring = dictionary["profile_image_url_https"] as? String
        if let profileURLstring = profileURLstring{
            profileURL = URL(string: profileURLstring)
        }
    }
    
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
