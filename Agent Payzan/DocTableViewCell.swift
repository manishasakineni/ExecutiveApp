//
//  DocTableViewCell.swift
//  Agent Payzan
//
//  Created by CalibrageMac02 on 23/11/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit

class DocTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageDoc: UIImageView!
    
    @IBOutlet weak var imageName: UILabel!

    @IBOutlet weak var dowloadBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var imageUrlLabel: UILabel!
    
    @IBOutlet weak var deleteId: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
