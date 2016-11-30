//
//  TweetCell.swift
//  TwttrLike
//
//  Created by Charles Wang on 11/12/16.
//  Copyright © 2016 Charles Wang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favsButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet{
            tweetMessageLabel.text = tweet.text
            timeStampLabel.text = tweet.timestamp?.timeSince() ?? "..."
            retweetLabel.text = "\(tweet.retweets)"
            favsLabel.text = "\(tweet.favorites)"
            if (tweet.favorites != 0) {
                favsButton.setImage(#imageLiteral(resourceName: "heart_active"), for:.normal)
            }
            if (tweet.retweets != 0) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet_active"), for:.normal)
            }
            if (tweet.favorites == 0) {
                favsButton.setImage(#imageLiteral(resourceName: "heart"), for:.normal)
            }
            if (tweet.retweets == 0) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet"), for:.normal)
            }
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
