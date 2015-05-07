//
//  SACFPoliticianDetailsVC.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/4/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import UIKit

class SACFPoliticianDetailsVC: UIViewController {

   @IBOutlet weak var navItem: UINavigationItem!
   
   @IBOutlet weak var tokenLBL: UILabel!
   
   var politician : SACFPolitician?
   
   @IBAction func requestTwitterToken(sender: AnyObject) {
      
      TwitterService.getBearerToken() { (token, error) in
         if (!error) {
            self.tokenLBL.text = token
         } else {
            self.tokenLBL.text = "ERROR"
         }
         println("BT: " + self.tokenLBL.text!)
      }
   }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      self.politician = SACFCongressManager.sharedInstance.selectedPolitician ?? nil
      
      navItem.title = self.politician?.lastname!
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
