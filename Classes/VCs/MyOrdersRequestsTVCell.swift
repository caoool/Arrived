//
//  MyOrdersRequestsTVCell.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MyOrdersRequestsTVCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inProgressIndicator: UIImageView!
    @IBOutlet weak var takersButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCell()
        
        backgroundColor = UIColorFromHex(0xFFFFFF, alpha: 0)
        bgView.alpha = 0.65
    }
    
    func setUpCell() {
        
        selectionStyle = .None
        
        bgView.roundCorners(.TopLeft | .BottomLeft, radius: bgView.layer.bounds.height/2)
        bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        bgView.layer.borderWidth = 0
        bgView.layer.cornerRadius = 8
        
        takersButton.layer.borderWidth = 1.2
        takersButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        takersButton.layer.cornerRadius = takersButton.layer.frame.height/2
        takersButton.alpha = 0.65
        
        inProgressIndicator.alpha = 0
    }

}
