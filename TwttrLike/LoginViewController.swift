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
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
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
        let client = TwitterClient.sharedInstance
        
        client.login(success: { 
            print("I've logged in")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (Error) in
            print(Error)
        }
    }
}
