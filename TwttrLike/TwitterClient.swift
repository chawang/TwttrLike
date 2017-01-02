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
    let defaults = UserDefaults.standard
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        loginWithAccessToken(requestToken: requestToken!)
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twttrLike://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in
            print("Request token received")
            let authorizeurl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(authorizeurl, options: [:], completionHandler: {(success: Bool) -> Void in
                print("Opened URL")
            })}, failure: {(error: Error?) -> Void in
                self.loginFailure?(error!)
        })
    }

    func loginWithAccessToken(requestToken: BDBOAuth1Credential) {
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {
            (accessToken: BDBOAuth1Credential?) -> () in
            self.currentAccount(success: {
                (user: User) -> () in
                User.currentUser = user
                
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                let UserAccessToken = TwitterClient.sharedInstance.requestSerializer.accessToken.token
                self.defaults.set(UserAccessToken, forKey: "UserAccessToken")
                self.defaults.synchronize()
                
                self.loginSuccess?()
            }, failure: {
                (error: Error) -> () in
                self.loginFailure?(error)
            })
        }, failure: {
            (error: Error?) -> () in
            self.loginFailure?(error!)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            User.currentUser = user
            //            print(userDictionary)
            success(user)
        }, failure: {(task: URLSessionDataTask?, response: Error) -> Void in
            failure(response)
        })
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> () ) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            let tweetDictionary = response as! [NSDictionary]
            let tweets = Tweet.tweetsFromArray(dictionaries: tweetDictionary)
            //            print(tweetDictionary)
            success(tweets)
        }, failure: {(task: URLSessionDataTask?, response: Error) -> Void in
            failure(response)
        })
    }
}
