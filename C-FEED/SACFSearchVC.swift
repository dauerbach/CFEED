//
//  SACFSearchVC.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON


class SACFSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   @IBOutlet weak var politicianList: UITableView!
   
   private var curCongress : Congress?
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      
      self.politicianList.dataSource = self
      self.politicianList.delegate = self
      
      // lets load current congress...
      
      Alamofire.request(.GET, "https://www.govtrack.us/api/v2/role?current=true", parameters: ["limit": "600"])
               .responseString { (request, response, jsonString, error) in
            
                  self.curCongress = Mapper<Congress>().map(jsonString!)
                  
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
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      var cell : UITableViewCell?
      
      if (tableView == politicianList) {
         
         if let pcell = (tableView.dequeueReusableCellWithIdentifier("rid_politician") as? PoliticianTVC) {
            
            pcell.nameLBL.text = self.curCongress?.members?[indexPath.row].politician?.name!
            pcell.districtLBL.text = self.curCongress?.members?[indexPath.row].getDistrict()
            pcell.partyLBL.text = self.curCongress?.members?[indexPath.row].party!
            
            return pcell

         }
         
         
      }
      return cell!

   }
   
}
