//
//  TwitterService.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/5/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class TwitterService {
   
   
   // Twitter API constants
   // TODO: Remove unnecessary constants
   static let twitter_auth_url = "https://api.twitter.com/oauth2/token"
   static let twitter_user_timeline_url = "https://api.twitter.com/1.1/statuses/user_timeline.json"
   
   static let twitter_consumer_key = "mJxbqoFKfcrMpEwznloWRxwbE"
   static let twitter_consumer_secret = "r0MQo0CEI7jRRn08RC9CgnjnyMrywGCAG0Ab3Dcny1RbUGXIqj"
   
   static let twitter_consumer_key_urlencoded = twitter_consumer_key.stringByAddingPercentEscapesForQueryValue()
   static let twitter_consumer_secret_urlencoded = twitter_consumer_secret.stringByAddingPercentEscapesForQueryValue()
   
   static let twitter_token_request = twitter_consumer_key + ":" + twitter_consumer_secret
   static let twitter_token_request_encoded = twitter_token_request.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
   
   static var twitter_bearer_token = ""
   static var twitter_timeline_request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: twitter_user_timeline_url)!)
   
   
   class func initialize() {
      
      // request bearer token from oauth endpoint
      TwitterService.getBearerToken { (token, error) -> Void in
         
         TwitterService.twitter_bearer_token = !error ? token : ""

      }
      
      // construct mutable URLRequest to be used for twitter data queries
      TwitterService.twitter_timeline_request = NSMutableURLRequest(URL: NSURL(string: twitter_user_timeline_url)!)
      TwitterService.twitter_timeline_request.HTTPMethod = "GET"
      TwitterService.twitter_timeline_request.setValue("Bearer " + twitter_token_request_encoded, forHTTPHeaderField: "Authorization")

      // TODO: Set up to accept variable params for queries
   }
   
   class func getTimeline(user : String, completion: (token : String, error : Bool) -> Void) {
      
      // TODO: implement getTimeline
   
   }
   
   class func getBearerToken(completion: (token : String, error : Bool) -> Void) {
      
      var token : String = ""
      
      // create mutable request so we can customize
      let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: TwitterService.twitter_auth_url)!)

      // per Twitter API docs for obtaining Bearer token from oauth2
      mutableURLRequest.HTTPMethod = "POST"
      mutableURLRequest.setValue("Basic " + TwitterService.twitter_token_request_encoded, forHTTPHeaderField: "Authorization")
      mutableURLRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
      mutableURLRequest.HTTPBody = "grant_type=client_credentials".dataUsingEncoding(NSUTF8StringEncoding)
      
      Alamofire.request(mutableURLRequest).responseJSON(options: .AllowFragments) { (request, response, jsondata, error) -> Void in

         // create nice dictionary from response
         let json = JSON(jsondata!)
         
         // if returned json has [ token_type" : "bearer" ]
         if (json["token_type"].stringValue == "bearer") {
            
            token = json["access_token"].stringValue
            
            // pass back to caller
            completion(token: token, error: false)
         
         } else {
            // set error flag and call completion
            completion(token: "Token NOT Obtained", error: true)
         }
      }
   }
   
}
