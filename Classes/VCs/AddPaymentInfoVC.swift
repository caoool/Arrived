//
//  AddPaymentInfoVC.swift
//  Arrived
//  Bank info recording is not implemented
//  This feature will be added as soon as the backend is ready
//
//  Created by Lu Cao on 4/19/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class AddPaymentInfoVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var cardLabel: UITextField!
    @IBOutlet weak var expDateLabel: UITextField!
    @IBOutlet weak var cvvLabel: UITextField!
    @IBOutlet weak var pinLabel: UITextField!
    @IBOutlet weak var pin2Label: UITextField!
    
    private var isSuccess: Bool?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func register(sender: UIButton) {
        
        if pinLabel.text != pin2Label.text || count(pin2Label.text) != 6 || pin2Label.text ~= "^([0-9]+)?(\\.([0-9]{1,2})?)?$" {
            displayAlert("Pin error", "Please enter the same 6 digit pin code")
            return
        }
        
        var dict = [String:String]()
        dict["phoneNumberId"] = NSUserDefaults.standardUserDefaults().stringForKey("phoneNumberId")!
        dict["fullName"] = nameLabel.text
        dict["bankCardNumber"] = cardLabel.text
        dict["expirationDate"] = expDateLabel.text
        dict["cvv"] = cvvLabel.text
        dict["pinCode"] = pin2Label.text
        
//        let service = UserService()
//        service.register(dict){
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            if checkErrorCodeInDictionary(result!) {
//                println("Successful created new user")
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
//                dispatch_async(dispatch_get_main_queue()) {
//                    self.performSegueWithIdentifier("AddPaymentInfoNewUserCreated", sender: self)
//                }
//            }
//
//        }
    }
}
