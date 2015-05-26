//
//  UserBankCardsTVCell.swift
//  Arrived
//
//  Created by Lu Cao on 5/3/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserBankCardsTVCell: UITableViewCell {

    
    @IBOutlet weak var bankCardNumber: SHSPhoneTextField!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var defaultIndicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        myView.layer.borderWidth = 0.3
        myView.layer.borderColor = UIColor.lightGrayColor().CGColor
        myView.layer.cornerRadius = 12
        
        defaultIndicator.roundCorners(.TopRight | .BottomRight, radius: 12)
        defaultIndicator.layer.backgroundColor = UIColorFromHex(0x3ABE68, alpha: 0.65).CGColor
        defaultIndicator.alpha = 0
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        defaultIndicator.hidden = false
    }

}
