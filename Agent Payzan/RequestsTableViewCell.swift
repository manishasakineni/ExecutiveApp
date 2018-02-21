//
//  RequestsTableViewCell.swift
//  Agent Payzan
//
//  Created by Nani Mac on 18/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var agentName: UILabel!
    
    @IBOutlet weak var businessCategory: UILabel!
    
    @IBOutlet weak var provience: UILabel!
    
    @IBOutlet weak var villageLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var pickUpBtn: UIButton!
    
    @IBOutlet weak var holdBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    @IBOutlet weak var commentsBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
