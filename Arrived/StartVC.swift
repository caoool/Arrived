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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // Check if user has logged in and has a phone number stored
        // Else lead the user to register (login) page
        if let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn") as Bool?, userPhoneNumber = NSUserDefaults.standardUserDefaults().stringForKey("userPhoneNumber") {
            if isUserLoggedIn {
                
                self.performSegueWithIdentifier("LoggedIn", sender: self)
            }
        } else {
            self.performSegueWithIdentifier("NewUser", sender: self)
        }
        
    }

}
