//
//  SACFSearchVC.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON


class SACFSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   @IBOutlet weak var politicianList: UITableView!
   
   private var curCongress : SACFCongress?
   
   private var sb : UIStoryboard?
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      
      self.sb = UIStoryboard(name: "Main", bundle: nil)
      
      self.politicianList.dataSource = self
      self.politicianList.delegate = self
      
      // lets load current congress...
      
      SACFRequestManager.requestCurrentCongress { (request, response, jsonString, error) in

                  self.curCongress = SACFCongress()
                  
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
                           self.curCongress?.addPolitician(pol!)
                        }
                     }
                     
                     
                  }
                  
                  self.curCongress?.sortCongress(.CurStateDistName)
                  self.politicianList.reloadData()
            
               }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
      if (tableView == politicianList) {
         return 1
      } else {
         return 0
      }
      
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      if (tableView == politicianList) {

         if let cnt = self.curCongress?.members?.count {
            return cnt
         } else {
            return 0
         }

      } else {
         return 0
      }
   }
   
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return 54.0
   }
   
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

      if let pol = self.curCongress?.members?[indexPath.row] {
         
         SACFRequestManager.requestPoliticianDetails(pol.id!, completion: { (request, response, jsonData, error) -> Void in
            
            var polDetails : SACFPolitician = Mapper<SACFPolitician>().map(jsonData)!
            
            self.curCongress?.members?[indexPath.row] = polDetails
            
            self.performSegueWithIdentifier("seg_politicianDetails", sender: self.curCongress?.members?[indexPath.row])
            
         })
      }
      
}
   
   func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
      
      if let pol = self.curCongress?.members?[indexPath.row] {
         
         SACFRequestManager.requestPoliticianDetails(pol.id!, completion: { (request, response, jsonData, error) -> Void in
            
            var polDetails : SACFPolitician = Mapper<SACFPolitician>().map(jsonData)!
            
            self.curCongress?.members?[indexPath.row] = polDetails
            
            self.performSegueWithIdentifier("seg_politicianDetails", sender: self.curCongress?.members?[indexPath.row])
            
         })
      }
      
      
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      var cell : UITableViewCell?
      
      if (tableView == politicianList) {
         
         if let pcell = (tableView.dequeueReusableCellWithIdentifier("rid_politician") as? PoliticianTVC) {
            
            pcell.nameLBL.text      = self.curCongress?.members?[indexPath.row].name!
               
//            pcell.descriptionLBL.text  = self.curCongress?.members?[indexPath.row].curRole?.description!
            
            pcell.partyLBL.text     = self.curCongress?.members?[indexPath.row].curRole?.party!
            
            return pcell

         }
         
         
      }
      return cell!

   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

      let dest = segue.destinationViewController as! SACFPoliticianDetailsNC
      
      dest.politician = (sender as! SACFPolitician)
      
   }
   
}
