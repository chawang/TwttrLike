//
//  LoginViewController.swift
//  TwttrLike
//
//  Created by Charles Wang on 10/29/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func onLogin(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "swdYnak7zKYag0e3krReLSfeb", consumerSecret: "qCbNk1IRTsVfHVajZrAxuNO8IyeRQ03lRlb48geXPAMzveamut")

        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twttrLike://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in
                print("Token received")
                let authorizeurl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
                UIApplication.shared.open(authorizeurl, options: [:], completionHandler: {(success: Bool) -> Void in
                    print("Opened URL")
                })
        }, failure: {(error: Error?) -> Void in
                print("Error: \(error?.localizedDescription)")
        })
    }
}
