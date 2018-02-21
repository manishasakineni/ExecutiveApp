//
//  InProgressTableViewCell.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 02/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class InProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstnameLabel: UILabel!
    
    @IBOutlet weak var mobileNumLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var businessCatgLabel: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    @IBOutlet weak var isActiveBtn: UIButton!
    
    
    @IBOutlet weak var reviewBtn: UIButton!
    
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
