//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Nick Tang on 9/19/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var tweetDate: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var favorited:Bool = false
    var tweetId: Int = -1
    var retweeted:Bool = false
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if(tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
   func setFavorite(_ isFavorited:Bool){
       favorited = isFavorited
       if(favorited){
           favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
       } else{
           favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
       }
   }
    
    @IBAction func retweet(_ sender: Any) {
        let tobeRetweeted = !retweeted
        if(tobeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: {(error) in
                print("Error in retweeting: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: {(error) in
                print("Error in unretweeting: \(error)")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
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

