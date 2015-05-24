//
//  UserMenuVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/24/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // hide status bar
//        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    @IBAction func unwindToMainViewController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
