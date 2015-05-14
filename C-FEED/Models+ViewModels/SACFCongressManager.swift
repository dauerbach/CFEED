//
//  SACFCongressManager.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/4/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Dollar

enum CongressSortType : String {
   
   case CurStateDistName = "State, Dist, Name"  // based on "current" Role + name
   case Name = "Name"                           // Just lastname, firstname
   
}

class SACFCongressManager  {
   
   static let sharedInstance = SACFCongressManager()

   private var congress : SACFCongress?
   
   var members : [SACFPolitician]? {
      get {
         return congress?.members
      }
   }
   var membersGrouped : [Int :[SACFPolitician]]? {
      get {
         return congress?.membersGrouped
      }
   }
   var selectedPolitician : SACFPolitician?
   
   private init() {
      
      self.congress = SACFCongress()
      
   }
   
   func loadCongressWithCompletion(completion: (success: Bool) -> Void) {
      // make async call to Govtracker to retrieve list of current congresspeople
      
      // only make call if mebers list not yet populated
      if let cnt = members?.count where (cnt == 0) {
         
         
         SACFRequestManager.requestCurrentCongress { (request, response, jsonString, error) in
            
            if (error == nil) {
               
               let json = JSON(jsonString!)
               let objs = json["objects"]
               let cnt = objs.count
               
               for (var ndx = 0; ndx < cnt; ndx++) {
                  
                  var role = Mapper<SACFRole>().map(objs[ndx].rawString()!)
                  var pol =  Mapper<SACFPolitician>().map(objs[ndx]["person"].rawString()!)
                  
                  pol?.curRole = role
                  
                  // filter out Pres and VP from GovTrack API data
                  if let roletype = pol?.curRole?.roleType {
                     if (roletype != "president") && (roletype != "vicepresident") {
                        self.congress!.addPolitician(pol!)
                     }
                  }
               }
               self.congress?.sortCongress(.CurStateDistName)
               
               completion(success: true)
               
            } else {
               
               completion(success: false)
               
            }
         }
         
      } else {
         
         // we already have a members of congress
         completion(success: true)
         
      }
      
   }
   
   
   func loadPoliticianWithCompletion(#politician : SACFPolitician, completion: (success: Bool) -> Void) {
      
      if !politician.detailedRecord {
         
         SACFRequestManager.requestPoliticianDetails(politician.id!) { (request, response, jsonData, error) in
            
            if (error == nil) {
               
               // create politician model from json
               var polDetailed : SACFPolitician = Mapper<SACFPolitician>().map(jsonData)!
               
               //update congress list with fresh politicians details.
               self.congress?.updatePolitician(polDetailed)
               
               self.selectedPolitician = polDetailed
               completion(success: true)
               
            } else {
               
               completion(success: false)
               
            }
         }

      } else {
         
         self.selectedPolitician = politician
         completion(success: true)
         
      }

   }
   
}

private class SACFCongress {
   
   //   var current : Bool = true
   var members          : [SACFPolitician]?
   var membersGrouped   : [Int : [SACFPolitician]]?
   
   private init() {
      
      self.members = []
      self.membersGrouped = [:]
      
   }
   
   func addPolitician(pol : SACFPolitician) {
      
      members?.append(pol)
      
   }
   
   func updatePolitician(pol : SACFPolitician) {
      
      // find index in member array using unique politicianID
      if let curIndex = ($.findIndex(members!, callback: { $0.id! == pol.id! })) {

         if (!(members![curIndex].detailedRecord)) {
            members?[curIndex] = pol
         }

      }
      
   }
   
   func sortCongress(sorttype : CongressSortType) {
      
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
         
         // now lets group by State
         var curState = ""
         var curGroupIndex = -1
         
         // reset...
         self.membersGrouped = [:]
         
         for mem in members! {
            
            if let state = mem.curRole?.state {
               if (state == curState) {
                  self.membersGrouped![curGroupIndex]?.append(mem)
               } else {
                  curGroupIndex++
                  curState = state
                  self.membersGrouped![curGroupIndex] = [mem]
               }
            }
            
         }
         
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

