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
   
   var politician : SACFPolitician?
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      navItem.title = self.politician?.name!
      
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
