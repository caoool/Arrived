//
//  UserBankCardsTVCell.swift
//  Arrived
//
//  Created by Lu Cao on 5/3/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserBankCardsTVCell: UITableViewCell {

    @IBOutlet weak var bankCardNumber: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var cvv: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
