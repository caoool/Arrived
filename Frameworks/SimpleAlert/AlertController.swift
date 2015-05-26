//
//  AlertController.swift
//  Arrived
//
//  Created by Lu Cao on 5/25/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class AlertController: SimpleAlert.Controller {
    override func addTextFieldWithConfigurationHandler(configurationHandler: ((UITextField!) -> Void)? = nil) {
        super.addTextFieldWithConfigurationHandler() { textField in
            textField.frame.size.height = 33
            textField.backgroundColor = UIColorFromHex(0x3D4656, alpha: 0.3)
            textField.layer.borderColor = UIColor.whiteColor().CGColor
            textField.layer.borderWidth = 0.3
            
            configurationHandler?(textField)
        }
    }
    
    override func configurButton(style :SimpleAlert.Action.Style, forButton button: UIButton) {
        super.configurButton(style, forButton: button)
        
        if let font = button.titleLabel?.font {
            switch style {
            case .OK:
                button.titleLabel?.font = UIFont(name: "American Typewriter", size: 19)
                button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            case .Cancel:
                button.titleLabel?.font = UIFont(name: "American Typewriter", size: 19)
                button.backgroundColor = UIColorFromHex(0x3D4656, alpha: 0.9)
                button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            case .Default:
                button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configContentView = { [weak self] view in
            if let view = view as? SimpleAlert.ContentView {
                view.titleLabel.textColor = UIColorFromHex(0x3D4656, alpha: 0.9)
                view.titleLabel.font = UIFont(name: "American Typewriter", size: 30)
                view.messageLabel.textColor = UIColor.lightGrayColor()
                view.messageLabel.font = UIFont(name: "American Typewriter", size: 16)
                view.textBackgroundView.layer.cornerRadius = 3.0
                view.textBackgroundView.clipsToBounds = true
            }
        }
    }
}