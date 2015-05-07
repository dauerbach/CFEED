//
//  SACFMainTabBarVC.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import UIKit
import MBProgressHUD

class SACFMainTabBarVC: UITabBarController {
   
   var hud = MBProgressHUD()
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      // lets load up a congress
      self.hud.minShowTime = 1.0
      self.hud.mode = MBProgressHUDMode.Indeterminate
      self.hud.show(true)
      self.hud.labelText = "Loading Congress Data..."
      
      SACFCongressManager.sharedInstance.loadCongressWithCompletion { (success) -> Void in

         self.hud.hide(true, afterDelay: 1.0)

      }
      
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
