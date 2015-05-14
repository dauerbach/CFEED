//
//  SACFPoliticianDetailsVC.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/4/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import UIKit

class SACFPoliticianDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

   @IBOutlet weak var navItem: UINavigationItem!
   
   @IBOutlet weak var tokenLBL: UILabel!
   @IBOutlet weak var menuTV: UITableView!
   
   var politician : SACFPolitician?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      self.politician = SACFCongressManager.sharedInstance.selectedPolitician ?? nil
      
      navItem.title = self.politician?.lastname!
      
      menuTV.dataSource = self
      menuTV.delegate = self
      menuTV.reloadData()
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("rid_sn") as! UITableViewCell
         
//         dequeueReusableCellWithIdentifier("rid_sn") as! UITableViewCell
      
      cell.textLabel?.text = "Twitter"
      
      return cell
   }
   
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      println("did select")
      
      self.performSegueWithIdentifier("seg_timeline", sender: self)
      
   }
   
}
