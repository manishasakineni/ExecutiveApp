//
//  AgentHistoryTableViewCell.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 28/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class AgentHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var assignToLabel: UILabel!

    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
 
    
    @IBOutlet weak var isActiveBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
