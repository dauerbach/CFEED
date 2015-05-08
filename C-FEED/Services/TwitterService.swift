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
   
   private static var instance : TwitterService?
   
   private let twitter_auth_url = "https://api.twitter.com/oauth2/token"
   private let twitter_user_timeline_url = "https://api.twitter.com/1.1/statuses/user_timeline.json"
   
   private let twitter_consumer_key : String = "mJxbqoFKfcrMpEwznloWRxwbE"
   private let twitter_consumer_secret : String = "r0MQo0CEI7jRRn08RC9CgnjnyMrywGCAG0Ab3Dcny1RbUGXIqj"

   private var twitter_token_request : String?
   private var twitter_token_request_encoded : String?
   
   private var twitter_bearer_token : String?
   

   
   class func sharedInstance() -> TwitterService {
      
      return (instance ?? TwitterService())
      
   }
   
   private init() {
      
      self.twitter_token_request         = self.twitter_consumer_key.stringByAddingPercentEscapesForQueryValue()! + ":" +
                                           self.twitter_consumer_secret.stringByAddingPercentEscapesForQueryValue()!
      
      self.twitter_token_request_encoded = self.twitter_token_request!.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

   }

   
   func MakeTimelineRequest(#screen_name : String) -> NSMutableURLRequest {
      
      // construct mutable URLRequest to be used for twitter data queries
      var request = NSMutableURLRequest(URL: NSURL(string: self.twitter_user_timeline_url)!)
      
      request.HTTPMethod = "GET"
      request.setValue("Bearer " + self.twitter_token_request_encoded!, forHTTPHeaderField: "Authorization")
      
      return request
   }
   
   func getTimeline(user : String, completion: (token : String, error : Bool) -> Void) {
      
      var request = MakeTimelineRequest(screen_name: "dadsoup")
      Alamofire.request(request).responseJSON(options: .AllowFragments) { (_, _, jsondata, error) -> Void in
         
         println(JSON(jsondata!))
         
      }
   
   }
   
   func getBearerToken(completion: (token : String, error : Bool) -> Void) {
      
      var token : String = ""
      
      // create mutable request so we can customize
      let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: self.twitter_auth_url)!)

      // per Twitter API docs for obtaining Bearer token from oauth2
      mutableURLRequest.HTTPMethod = "POST"
      mutableURLRequest.setValue("Basic " + self.twitter_token_request_encoded!, forHTTPHeaderField: "Authorization")
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
