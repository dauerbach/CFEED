//
//  SACFPolitician.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import Foundation
import ObjectMapper

enum PoliticalParty : String {
   case Republican = "GOP"
   case Democratic = "DEM"
   case Other = "OTHER"
}

class Congress : Mappable {
   
   var current : Bool = true
   var members : [Role]?
   
   required init?(_ map: Map) {
      mapping(map)
   }
   
   // Mappable
   func mapping(map: Map) {
      
      members <- map["objects"]
      
   }
}


class Politician : Mappable {
   
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

   
   
}