//
//  PoliticianTVC.swift
//  C-FEED
//
//  Created by Dan Auerbach on 5/3/15.
//  Copyright (c) 2015 SoupyApps. All rights reserved.
//

import UIKit

class PoliticianTVC: UITableViewCell {
   
   @IBOutlet weak var partyLBL: UILabel!
   @IBOutlet weak var nameLBL: UILabel!
   @IBOutlet weak var districtLBL: UILabel!
   @IBOutlet weak var titleLBL: UILabel!
   
//   var party : String?
//   var title : String?
//   var name : String?
//   var district : String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
