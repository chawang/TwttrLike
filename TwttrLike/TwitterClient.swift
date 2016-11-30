//
//  TwitterClient.swift
//  TwttrLike
//
//  Created by Charles Wang on 11/1/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "swdYnak7zKYag0e3krReLSfeb", consumerSecret: "qCbNk1IRTsVfHVajZrAxuNO8IyeRQ03lRlb48geXPAMzveamut")!
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twttrLike://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in
            print("Token received")
            let authorizeurl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(authorizeurl, options: [:], completionHandler: {(success: Bool) -> Void in
                print("Opened URL")
            })
            }, failure: {(error: Error?) -> Void in
                self.loginFailure?(error!)
        })
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "/oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential?) -> Void in
            print ("Got access token!")
            
            self.accountInfo(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: Error) in
                    self.loginFailure?(error)
            })}, failure: {(error: Error?) -> Void in
                print("\(error?.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> () ) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            let tweetDictionary = response as! [NSDictionary]
            let tweets = Tweet.tweetsFromArray(dictionaries: tweetDictionary)
            
            print(tweetDictionary)
            
            success(tweets)
            }, failure: {(task: URLSessionDataTask?, response: Error) -> Void in
                failure(response)
        })
    }
    
    func accountInfo(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)

//            print(userDictionary)

            success(user)
            }, failure: {(task: URLSessionDataTask?, response: Error) -> Void in
                failure(response)
        })
    }
    
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
}
