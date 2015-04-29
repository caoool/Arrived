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
    
    @IBOutlet weak var smsButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    private var phoneNumberId: String?
    private var verificationCode: String?
    private var isNewUser: String?
    
    private var timeBeforeNextSMS: Int = 60
    private var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sms.hidden = true
        LoginButton.hidden = true
        
    }
    
    func count() {
        smsButton.setTitle("\(--timeBeforeNextSMS)", forState: .Disabled)
        if timeBeforeNextSMS < 1 {
            timer?.invalidate()
            timeBeforeNextSMS = 59
        }
    }
    
    @IBAction func smsButtonPressed() {
        
        let service = UserService()
        
        service.verify(["phoneNumber": phone.text]) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            // print result for testing purpose
            println(result)
            
            // prompt alert if connection error
            if error != nil
            {
                displayAlert("Connection Error", error!)
                return
            }
            
            // check code from result, if code = 20000, no error, vise versa
            if checkErrorCodeInDictionary(result!) {
                // disable button and reactive after time
                dispatch_async(dispatch_get_main_queue()) {
                    self.smsButton.enabled = false
                    self.smsButton.setTitle("60", forState: .Disabled)
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("count"), userInfo: nil, repeats: true)
                    self.sms.hidden = false
                    self.LoginButton.hidden = false
                }
            }
        }
        
    }
    
    @IBAction func loginButtonPressed() {
        
        if sms.text == nil || verificationCode == nil || sms.text! != verificationCode!
        {
            // display alert if sms code doesn't match
            displayAlert("SMS Code Error", "Please make sure to enter the correct sms code")
            
        }
        
        let service = UserService()
        
        service.authenticate(["phoneNumber": phone.text, "verificationCode": sms.text]) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            // print result for testing purpose
            println(result!)
            
            // prompt alert if connection error
            if error != nil
            {
                displayAlert("Connection Error", error!)
                return
            }
            
            if checkErrorCodeInDictionary(result!) {
                if let data = result!["data"] as? Dictionary<String, AnyObject> {
                    self.phoneNumberId = data["uid"] as? String
                    self.verificationCode = data["verificationCode"] as? String
                    self.isNewUser = data["isNewUser"] as? String
                    println("Phone Number ID = \(self.phoneNumberId!)")
                    println("Verification Code = \(self.verificationCode!)")
                    println("Is new user = \(self.isNewUser!)")
                }
            }
        }
        
        if isNewUser == "true"
        {
            NSUserDefaults.standardUserDefaults().setValue(phoneNumberId, forKey: "phoneNumberId")
            performSegueWithIdentifier("WelcomeSignUp", sender: self)
            
        } else
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().setValue(phoneNumberId, forKey: "phoneNumberId")
            performSegueWithIdentifier("WelcomeLogin", sender: self)
        }
    }
    
}
