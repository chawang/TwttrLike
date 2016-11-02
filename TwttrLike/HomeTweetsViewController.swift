//
//  HomeTweetsViewController.swift
//  TwttrLike
//
//  Created by Charles Wang on 11/1/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit

class HomeTweetsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TwitterClient.sharedInstance
        
        client.homeTimeline(success: { (tweets: [Tweet]) in
            for tweet in tweets {
                print("text:\(tweet.text)")
                print("favs:\(tweet.favorites)")
                print("retweets:\(tweet.retweets)")
                print("timestamp:\(tweet.timestamp)")
            }
        }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
        
        client.accountInfo(success: { (user: User) in
            print("name:\(user.name)")
            print("screenname:\(user.screenname)")
            print("profile url:\(user.profileURL)")
        }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
