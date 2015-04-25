//
//  StartVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        if let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn") as Bool?,
            phoneNumberId = NSUserDefaults.standardUserDefaults().stringForKey("phoneNumberId")
        {
            if isUserLoggedIn {
                println("User is logged in")
                performSegueWithIdentifier("LoggedIn", sender: self)
            } else {
                println("Register new user")
                performSegueWithIdentifier("NewUser", sender: self)
            }
        } else
        {
            println("Register new user")
            performSegueWithIdentifier("NewUser", sender: self)
        }
        
    }

}
