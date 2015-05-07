//
//  TwitterUser.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/5/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import Foundation
import ObjectMapper

class SACFTwitterUser : Mappable {
   
   var id : Int?
   var bioguideid : String?
   var birthday : String?
   var cspanid : String?
   var firstname : String?
   var middlename : String?
   var lastname : String?
   var name : String?
   var sortname : String?
   var govtrackLink : String?
   var twitterid : String?
   var youtubeid : String?
   
   // not mapped properties
   var curRole : SACFRole?
   var detailedRecord = false
   
   
   required init?(_ map: Map) {
      mapping(map)
   }
   
   // Mappable
   func mapping(map: Map) {
      
      id              <- map["id"]
      bioguideid      <- map["bioguideid"]
      birthday        <- map["birthday"]
      cspanid         <- map["cspanid"]
      firstname       <- map["firstname"]
      middlename      <- map["middlename"]
      lastname        <- map["lastname"]
      name            <- map["name"]
      sortname        <- map["sortname"]
      govtrackLink    <- map["link"]
      twitterid       <- map["twitterid"]
      youtubeid       <- map["youtubeid"]
      
   }
   
   func fullName() -> String {
      // return the full name with Title from current Role, if any
      
      var fn = ""
      if let title = self.curRole?.title {
         fn += title + " "
      }
      fn += self.firstname! + " " + self.lastname!
      
      return fn
      
   }
   
   
}