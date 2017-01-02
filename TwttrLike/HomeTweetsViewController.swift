//
//  HomeTweetsViewController.swift
//  TwttrLike
//
//  Created by Charles Wang on 11/1/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit

class HomeTweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var client = TwitterClient.sharedInstance
    var homeTweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        client.homeTimeline(success: { (tweets: [Tweet]) in
            self.homeTweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
        
//        client.accountInfo(success: { (user: User) in
//            print("name:\(user.name)")
//            print("screenname:\(user.screenname)")
//            print("profile url:\(user.profileURL)")
//        }, failure: { (error: Error) in
//                print(error.localizedDescription)
//        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return homeTweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = homeTweets[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        client.homeTimeline(success: { (tweets: [Tweet]) in
            self.homeTweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        refreshControl.endRefreshing()
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
