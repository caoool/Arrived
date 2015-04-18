//
//  LoggedInVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class LoggedInVC: UIViewController {

    @IBOutlet weak var userInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInfo.text = user.phoneNumberId
    }
    
    @IBAction func logout() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("phoneNumberId")
        user.clear()
    }
    
    @IBAction func updateUserInfo() {
        performSegueWithIdentifier("UpdateUserInfo", sender: self)
    }

}
