//
//  SACFTwitterTimeline.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/11/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import UIKit
import SwiftyJSON
import TwitterKit

class SACFTwitterTimeline: UIViewController, UITableViewDelegate, UITableViewDataSource, TWTRTweetViewDelegate {

   @IBOutlet weak var timelineTV: UITableView!
   
   // Tweet cell RID
   private let tweetTableReuseIdentifier = "TweetCell"

   // Hold all the loaded Tweets
   private var tweets: [TWTRTweet] = [] {
      didSet {
         timelineTV.reloadData()
      }
   }

   
    override func viewDidLoad() {
      
      super.viewDidLoad()
      
        // Do any additional setup after loading the view.
      
      // set up tableview for Twitter/Fabric cells
      timelineTV.estimatedRowHeight = 150
      timelineTV.rowHeight = UITableViewAutomaticDimension // Explicitly set on iOS 8 if using automatic row height calculation
      timelineTV.allowsSelection = false
      timelineTV.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: tweetTableReuseIdentifier)

      
      // Create an array of tweet model objects from a JSON array
      TwitterService.sharedInstance().getTimelineForScreenname(user: "dadsoup") { (tweetData, error) -> Void in
         if !error {
            
            self.tweets = TWTRTweet.tweetsWithJSONArray(tweetData) as! [TWTRTweet]
            
         }
      }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.tweets.count
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let tweet = self.tweets[indexPath.row]
      let cell = timelineTV.dequeueReusableCellWithIdentifier(tweetTableReuseIdentifier, forIndexPath: indexPath) as! TWTRTweetTableViewCell
      
      cell.configureWithTweet(tweet)
      cell.tweetView.delegate = self
      
      return cell

   }
   
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
      let tweet = tweets[indexPath.row]
      return TWTRTweetTableViewCell.heightForTweet(tweet, width: CGRectGetWidth(self.view.bounds))
      
   }
   

}
