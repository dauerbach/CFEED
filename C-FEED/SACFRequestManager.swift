//
//  SACFRequestManager.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import Foundation
import Alamofire

class SACFRequestManager {
   
   class func requestCurrentCongress(completion: (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void ) {
   
      Alamofire.request(.GET, "https://www.govtrack.us/api/v2/role?current=true", parameters: ["limit": "600"]).responseJSON(completionHandler: completion)
      
   }
   
   class func requestPoliticianDetails(govTrackID : Int, completion: (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void ) {
    
      Alamofire.request(.GET, "https://www.govtrack.us/api/v2/person/\(govTrackID)", parameters: ["limit": "600"]).responseJSON(completionHandler: completion)
      
   }
}