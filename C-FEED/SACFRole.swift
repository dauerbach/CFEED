//
//  Role.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

class SACFRole : Mappable {
   
   var caucus : String?
   var current : Bool?

   var district : Int?
   var description : String?

   var party : String?
   
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
      
      officePhone <- map["phone"]
      roleType    <- map["role_type"]
      state       <- map["state"]
      title       <- map["title"]
      websiteURL  <- map["website"]
      
   }
   
   func getDistrict() -> String {
      
      var distStr : String = ""
      
      // see if district-specific info exists
      if let dist = self.district {

         if dist == 0 {
            // at large Rep (e.g. AK, RI...)
            distStr = "\(self.state!) (A/L)"
            
         } else {
            
            distStr = "\(self.state!)-\(dist)"
         }
         
      } else {
         // no district info, just return state info
         
         distStr = self.state!
         
      }
      
      return distStr
   }
   
}