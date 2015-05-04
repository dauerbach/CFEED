//
//  Role.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import Foundation
import ObjectMapper

class Role : Mappable {
   
   var caucus : String?
   var current : Bool?

   var district : String?
   var description : String?

   var party : String?
   
   var politician : Politician?
   
   var officePhone : String?
   var roleType : String?
   var state : String?
   var title : String?
   var websiteURL : String?
   
   
   required init?(_ map: Map) {
      mapping(map)
   }
   
   // Mappable
   func mapping(map: Map) {
      
      caucus      <- map["caucus"]
      current     <- map["current"]
      
      description <- map["description"]
      district    <- map["district"]

      party       <- map["party"]
      
      politician  <- map["person"]
      
      officePhone <- map["phone"]
      roleType    <- map["role_type"]
      state       <- map["state"]
      title       <- map["title"]
      websiteURL  <- map["website"]
      
   }
   
   func getDistrict() -> String {
      
      if let dist = self.district {
         return "\(self.state)-\(self.district)"
      } else {
         return self.state!
      }
   }
   
   
   
}