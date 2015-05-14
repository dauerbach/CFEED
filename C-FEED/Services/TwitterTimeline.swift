//
//  SACFTwitterTimeline.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/11/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import Foundation
import ObjectMapper

class TwitterTimeline : Mappable {
   
   var name          : String?
   var screen_name   : String?
   var tweets        : [SACFTwitterTweet]?
   
   // not mapped properties
   var created_at_local : NSDate?
   
   
   required init?(_ map: Map) {
      mapping(map)
   }
   
   // Mappable
   func mapping(map: Map) {
      
      self.name          <- map["user.name"]
      self.screen_name   <- map["user.screen_name"]
      self.tweets        <- map["text"]
//      self.created_at    <- map["created_at"]
//      self.utc_offset    <- map["user.utc_offset"]
//      self.urls          <- map["entities.urls"]
//      self.profile_img   <- map["user.profile_image_url_https"]
      
   }
   
}