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

   private var twitter_bearer_token : String? {
      didSet {
         hasBearerToken = (twitter_bearer_token != "")
      }
   }
   private var hasBearerToken : Bool = false
   

   
   class func sharedInstance() -> TwitterService {
      
      // return instance or create it
      instance = (instance ?? TwitterService())
      return instance!
      
   }
   
   private init() {
      
      // make init private to prevent multi-instantiation of Service
      
   }
   
   
   func setKeys(#consumer_key : String, consumer_secret : String) {
      
      if (consumer_key != "") && (consumer_secret != "") {
         
         getBearerToken(key: consumer_key, secret: consumer_secret, completion: { (token : String, error : Bool) -> Void in
            
            if (!error) {
               
               // save Bearer token for future use...
               self.twitter_bearer_token = token //"AAAAAAAAAAAAAAAAAAAAABxLfgAAAAAAxNdc3oaRV6sU%2F9g99NoY70KDhNQ%3DseTevFOEXsQSVyIToqDCmqWVjW519AapyBFf3i4Eg7vCQZigob"
               println("Got token: \(token)")
               
            } else {
               
               println("error getting Twitter API Bearer token")
               self.twitter_bearer_token = ""
               
            }
            
         })
         
      }
      
   }
   func getTimelineForScreenname(#user : String, completion: (tweetData : [AnyObject], error : Bool) -> Void) {
      
      if let request = makeTimelineRequest(screen_name: user) {

         Alamofire.request(request).responseJSON() {
               
            (_, _, jsondata, error) -> Void in
            
            if let err = error {
               
               completion(tweetData: [], error: true)
               
            } else if let json : [AnyObject] = jsondata as? [AnyObject] {

               println(json[0])
               completion(tweetData: json, error: false)
               
            }
         }
      }
   
   }
   
   private func makeTimelineRequest(#screen_name : String) -> NSMutableURLRequest? {
      
      var request : NSMutableURLRequest? = nil
      
      if self.hasBearerToken {
         
         // construct mutable URLRequest to be used for twitter data queries
         request = NSMutableURLRequest(URL: NSURL(string: "\(self.twitter_user_timeline_url)?screen_name=\(screen_name)&count=5")!)
         if let req = request {
            req.HTTPMethod = "GET"
            req.setValue("Bearer " + self.twitter_bearer_token!, forHTTPHeaderField: "Authorization")
            
            println("Request: \(self.twitter_bearer_token!)")
         }
         
      }
      
      return request
   }
   
   private func getBearerToken(#key: String, secret : String, completion: (token : String, error : Bool) -> Void) {
   // make async call to get twitter bearer token
      
      
      // make sure API keys have been set
      if (key != "") && (secret != "") {
         
         let twitter_token_request  = key.stringByAddingPercentEscapesForQueryValue()! + ":" +
                                       secret.stringByAddingPercentEscapesForQueryValue()!
         
         let twitter_token_request_encoded = twitter_token_request.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
         
         // create mutable request so we can customize
         let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: self.twitter_auth_url)!)

         // per Twitter API docs for obtaining Bearer token from oauth2
         mutableURLRequest.HTTPMethod = "POST"
         mutableURLRequest.setValue("Basic " + twitter_token_request_encoded, forHTTPHeaderField: "Authorization")
         mutableURLRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
         mutableURLRequest.HTTPBody = "grant_type=client_credentials".dataUsingEncoding(NSUTF8StringEncoding)
         
         println("Basic " + twitter_token_request_encoded)
         
         // make server call
         Alamofire.request(mutableURLRequest).responseJSON(options: .AllowFragments) { (request, response, jsondata, error) -> Void in

            // create nice dictionary from response
            let json = JSON(jsondata!)
            
            // if returned json has [ token_type" : "bearer" ]
            if (json["token_type"].stringValue == "bearer") {
               
               // if successful, get token from response
               let token = json["access_token"].stringValue
               
               // pass token back to caller
               completion(token: token, error: false)
            
            } else {
               // set error flag and call completion
               completion(token: "Token NOT Obtained", error: true)
            }
         }
      } else {
         completion(token: "Twitter API Keys not set", error: true)
      }
      
   }
   
}
