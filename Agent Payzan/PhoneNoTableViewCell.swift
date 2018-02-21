//
//  PhoneNoTableViewCell.swift
//  Agent Payzan
//
//  Created by Nani Mac on 07/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class PhoneNoTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneNoDropdownBtn: UIButton!
    

    @IBOutlet weak var phoneNoTF: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
