//
//  TweetCell.swift
//  TwttrLike
//
//  Created by Charles Wang on 11/12/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favsLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favsButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet{
            userImageView.setImageWith((tweet.user?.profileURL)!)
            userImageView.backgroundColor = UIColor.gray
            userImageView.layer.cornerRadius = 10
            userImageView.clipsToBounds = true

            //            nameLabel.text = tweet.name
            //            screenNameLabel.text = "@" + tweet.screenName!
            
            nameLabel.text = tweet.user?.name
            screenNameLabel.text = "@" + (tweet.user?.screenname)!
            tweetMessageLabel.text = tweet.tweetMessage
            
            retweetLabel.text = "\(tweet.retweets)"
            if (tweet.retweets != 0) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet_active"), for:.normal)
            }
            if (tweet.retweets == 0) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet"), for:.normal)
            }
            
            favsLabel.text = "\(tweet.favorites)"
            if (tweet.favorites != 0) {
                favsButton.setImage(#imageLiteral(resourceName: "heart_active"), for:.normal)
            }
            if (tweet.favorites == 0) {
                favsButton.setImage(#imageLiteral(resourceName: "heart"), for:.normal)
            }
            
            timeStampLabel.text = tweet.timestamp?.timeSince() ?? "..."
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
