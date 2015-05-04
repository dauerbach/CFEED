//
//  ViewController.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/2/15.
//  Copyright (c) 2015 Datatask Solutions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

   @IBOutlet weak var dataView: UITextView!
   
   private var names : [String] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func getGovTrackData(sender: AnyObject) {
      
      Alamofire.request(.GET, "https://www.govtrack.us/api/v2/role?current=true", parameters: ["limit": "600"])
         .responseJSON(options: .AllowFragments) { (request, response, jsondata, error) in
            
            let json : JSON = JSON(jsondata!)
            let c_list = json["objects"]
            
            for ndx in 0..<c_list.count {

               self.names.append(c_list[ndx]["person"]["name"].string!)

            }
            
            let str : String = "\n".join(self.names)
            self.dataView.text = "First: \(c_list.count) CongressPeople\n\(str)"
               }
      
      
   }

}

