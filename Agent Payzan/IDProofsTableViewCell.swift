//
//  IDProofsTableViewCell.swift
//  Agent Payzan
//
//  Created by N@n!'$ Mac on 23/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class IDProofsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var idNameLbl: UILabel!
    

    @IBOutlet weak var idNumberLbl: UILabel!
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    var idProofTypeIDLbl  = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
