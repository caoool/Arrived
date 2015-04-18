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
    
    private var verificationCode: String?
    private var isNewUser: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verify() {
        let result = user.verify(phone.text)
        verificationCode = result.code
        isNewUser = result.isNew
        println(result.code!)
    }
    
    @IBAction func login() {
        if verificationCode == sms.text {
            if isNewUser != nil {
                if isNewUser! {
                    self.performSegueWithIdentifier("SignUp", sender: self)
                }
            }
        } else {
                let alertController = UIAlertController(title: "Wrong sms code", message:
                    "Please check and enter again", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}
