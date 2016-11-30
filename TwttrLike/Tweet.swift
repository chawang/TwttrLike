//
//  Tweet.swift
//  TwttrLike
//
//  Created by Charles Wang on 10/30/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    
//    var name: String?
//    var screenName: String?
    var tweetMessage: String?
    
    var favorites: Int = 0
    var retweets: Int = 0
    var timestamp: Date?
    
    init(dictionary:NSDictionary){
        let userDictionary = dictionary["user"] as? NSDictionary
        user = User(dictionary: userDictionary!)
        
//        name = userDictionary!["name"] as? String
//        screenName = userDictionary!["screen_name"] as? String
        
        tweetMessage = dictionary["text"] as? String
        favorites = (dictionary["favorite_count"] as? Int) ?? 0
        retweets = (dictionary["retweet_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            timestamp = formatter.date(from: timestampString)
        }
        
    }
    
    class func tweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
