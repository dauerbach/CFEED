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


class SACFCongressVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
   
   @IBOutlet weak var politicianList: UITableView!
   
   private var sb : UIStoryboard?
   private var isFiltered : Bool = false
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      
      self.sb = UIStoryboard(name: "Main", bundle: nil)
      
      self.politicianList.dataSource = self
      self.politicianList.delegate = self
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   
   
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
      if (tableView == politicianList) {
         
         return count(SACFCongressManager.sharedInstance.membersGrouped!)
         
      } else {
         
         return 0
         
      }
      
   }
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      if (tableView == politicianList) {

         return (SACFCongressManager.sharedInstance.membersGrouped?[section]?.count ?? 0)

      } else {
         
         return 0
      }
   }
   
   func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return SACFCongressManager.sharedInstance.membersGrouped?[section]![0].curRole!.state
   }
   
   
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return 54.0
   }
   
   
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

      if let pol = SACFCongressManager.sharedInstance.membersGrouped?[indexPath.section]![indexPath.row] {
         
         SACFCongressManager.sharedInstance.loadPoliticianWithCompletion(politician: pol, completion: { (success) in
            
            if (success) {
               // got politician details...
            
               // instantiate "details" vc and push into nav stack
               if let destVC = self.sb?.instantiateViewControllerWithIdentifier("vc_politicianDetails") as? SACFPoliticianDetailsVC {
                  
                  self.navigationController?.pushViewController(destVC, animated: true)
                  
               }
            } else {
               
               // show error alert
               let alert = UIAlertController(title: "ERROR", message: "Error retrieving GovTrack details for \(pol.fullName())", preferredStyle: UIAlertControllerStyle.Alert)
               self.presentViewController(alert, animated: true, completion: nil)
            }

         })
      }
      
   }
   
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      var cell : UITableViewCell?
      
      if (tableView == politicianList) {
         
         if let pcell = (tableView.dequeueReusableCellWithIdentifier("rid_politician") as? SACFPoliticianTVC) {
            
            pcell.nameLBL.text      = SACFCongressManager.sharedInstance.membersGrouped?[indexPath.section]![indexPath.row].name!
            pcell.partyLBL.text      = SACFCongressManager.sharedInstance.membersGrouped?[indexPath.section]![indexPath.row].curRole?.party!
            return pcell

         }
         
         
      }
      return cell!

   }
   
}
