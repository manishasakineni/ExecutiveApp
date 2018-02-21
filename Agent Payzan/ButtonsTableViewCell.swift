//
//  ButtonsTableViewCell.swift
//  Agent Payzan
//
//  Created by Nani Mac on 07/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class ButtonsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    

    @IBOutlet weak var sendBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
