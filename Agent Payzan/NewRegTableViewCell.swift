//
//  NewRegTableViewCell.swift
//  Agent Payzan
//
//  Created by Nani Mac on 06/10/17.
//  Copyright © 2017 Naveen. All rights reserved.
//

import UIKit
import TextFieldEffects

class NewRegTableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var dropDownImg: UIImageView!
    
    @IBOutlet weak var detailsTextField: TextFieldEffects!
   
    @IBOutlet weak var textfieldHeight: NSLayoutConstraint!
    
    @IBOutlet weak var detailLbl: UILabel!
    
    var eyeIconBtn = UIButton(type: .custom)
    
    @IBOutlet weak var detailTFHeight: NSLayoutConstraint!
    @IBOutlet weak var eyeBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        eyeIconBtn.setImage(UIImage(named: "eye2"), for: .normal)
        eyeIconBtn.contentMode = .scaleAspectFit
        eyeIconBtn.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        eyeIconBtn.tintColor = #colorLiteral(red: 0.5568627451, green: 0.1254901961, blue: 0.1647058824, alpha: 1)
  
        
        
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        paddingView.addSubview(eyeIconBtn)
        detailsTextField.rightViewMode = .always
        detailsTextField.rightView = paddingView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
