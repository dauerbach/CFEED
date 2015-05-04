//
//  Congress.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import Foundation


class SACFCongress {
   
   enum SortType : String {
      
      case CurStateDistName = "State, Dist, Name"  // based on "current" Role + name
      case Name = "Name"                           // Just lastname, firstname
      
   }
   
   var current : Bool = true
   var members : [SACFPolitician]?
    
   required init() {
      
      self.members = []

   }
   
   func addPolitician(pol : SACFPolitician) {

      members?.append(pol)
      
   }
   
   func sortCongress(sorttype : SortType) {
      
      switch (sorttype) {
         
      case .CurStateDistName:
         
         // sort inline by state asc, district, lastname asc
         
         members?.sort({ (p1, p2) -> Bool in
            
            if (p1.curRole?.state! == p2.curRole?.state!) {
               
               // states are the same, check districts
               if let dist1 = p1.curRole?.district, dist2 = p2.curRole?.district {
                  
                  // both districts specified, so sort
                  return (dist1 < dist2)
                  
               } else if let dist1 = p1.curRole?.district {

                  // must mean dist2 empty which ==> Senator, so put p2 first
                  return false
                  
               } else if let dist2 = p2.curRole?.district {

                  // must mean dist1 empty which ==> Senator, so put p2 first
                  return true
                  
               } else {
                  
                  // district(s) unavail, so use lastname
                  return (p1.lastname! < p2.lastname!)
                  
               }
            } else {
               
               return (p1.curRole?.state! < p2.curRole?.state!)
               
            }
            
         })

      case .Name:
         
         // sort inline by lastname, firstname asc
         
         members?.sort({ (p1, p2) -> Bool in
            
            if (p1.lastname! == p2.lastname!) {
               
               // lastnames the same, sort by firstname
               return (p1.firstname! < p2.firstname!)
               
            } else {
               
               // easy sort by lastname
               return (p1.lastname! < p2.lastname!)
            }
            
         })
      }
      
   }
   
}
