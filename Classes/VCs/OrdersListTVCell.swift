//
//  OrdersListTVCell.swift
//  Arrived
//
//  Created by Lu Cao on 5/11/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class OrdersListTVCell: UITableViewCell {

    
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
