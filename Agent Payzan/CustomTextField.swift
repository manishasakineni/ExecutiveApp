//
//  CustomTextField.swift
//  Young Inc
//
//  Created by Calibrage Mac on 12/06/17.
//  Copyright © 2017 CALIBRAGE. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
