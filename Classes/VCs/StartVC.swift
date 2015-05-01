//
//  StartVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

let user = User()

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        checkLogin()
        
    }
    
    func checkLogin() {
        if let phoneNumber = NSUserDefaults.standardUserDefaults().stringForKey("phoneNumber"),
            verificationCode = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode") {
                
                var dict = Dictionary<String, AnyObject>()
                
                let service = TestUserService()
                service.authenticate(dict) {
                    (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
                    
                    // print result for testing purpose
                    println(result!)
                    
                    // prompt alert if connection error
                    if error != nil
                    {
                        displayAlert("Verify - Connection Error", error!)
                        return
                    }
                    
                    // check code from result, if code = 20000, no error, vise versa
                    if checkErrorCodeInDictionary(result!) {
                        println("User Logged In")
                        self.performSegueWithIdentifier("LoggedIn", sender: self)
                        return
                    } else {
                        println("Register new user")
                        self.performSegueWithIdentifier("NewUser", sender: self)
                    }
                }
        } else {
            println("Register new user")
            performSegueWithIdentifier("NewUser", sender: self)
        }
        
    }
    
    
    
}
