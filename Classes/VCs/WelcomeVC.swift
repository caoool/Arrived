//
//  WelcomeVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var sms: UITextField!
    
    private var phoneNumberId: String?
    private var isSuccess: String?
    private var verificationCode: String?
    private var isNewUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func smsButtonPressed() {
        
        let service = UserService()
        service.verify(phone.text) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            println(result!)
            
            if error != nil {
                println(error)
                let alertController = UIAlertController(title: "Connection Error",
                    message: "Please check the internet and try again",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            if let data = result!["data"] as? Dictionary<String, AnyObject> {
                if let isSuccess = data["isSuccess"] as? String {
                    if isSuccess == "true" {
                        
                        self.phoneNumberId = data["phoneNumberId"] as? String
                        self.isSuccess = data["isSuccess"] as? String
                        self.verificationCode = data["verificationCode"] as? String
                        self.isNewUser = data["isNewUser"] as? String
                    } else {
                        print(result!["code"])
                        println(result!["message"])
                    }
                } else { println("Can't read isSuccess in data") }
            } else { println("Can't read data in result") }
            
        }
    }

    @IBAction func loginButtonPressed() {
        if isSuccess != "true" { return }
        
        if sms.text != verificationCode! {
            let alertController = UIAlertController(title: "SMS Code Error",
                message: "Please make sure to enter the correct sms code",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss",
                style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if isNewUser == "true" {
            NSUserDefaults.standardUserDefaults().setValue(phoneNumberId, forKey: "phoneNumberId")
            performSegueWithIdentifier("WelcomeSignUp", sender: self)
        } else {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().setValue(phoneNumberId, forKey: "phoneNumberId")
            performSegueWithIdentifier("WelcomeLogin", sender: self)
        }
    }

}
